Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8685EBB94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiI0HfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiI0HfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:35:07 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F75140E4;
        Tue, 27 Sep 2022 00:35:04 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d15so5540628qka.9;
        Tue, 27 Sep 2022 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Iva8djnsoEGavqO2e35Aa/Y4zh21Iw1HIh/3kt9CYVw=;
        b=TqWrNqA08yJ1QmcRmdAjVd7FE4fa1mA4kDfqKxNNf5QdtIUMQFScby3w3BRkDs9230
         +hELU8sRtnGMLIbvgPQEmcDCwxv8I/4spFbACL9Mn9V8QGF1hLxJdQfJspwB0NAfXT11
         +8HnU04htn7BvZpH3iiLxjdVgMASUQsxa0D2pt+vxHaHW1mFY9Y4MV7vG/fGOZbGoqCB
         ySe02NNKpcnAzw599IMTf/5FM8lJVxc2+x9ygsfpKJ78t8M7b64I8virWuMUM+dvkNLV
         kUUEv8FtdzsnfUAwubhVboOilZ7luwjT/4X01isILYB69/BhtQFIwizqIBvKw9Eqxg8y
         xEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Iva8djnsoEGavqO2e35Aa/Y4zh21Iw1HIh/3kt9CYVw=;
        b=yrD0RYcx+9WniDbt1u6D5hMthLxmLhO7ZMKTzuKbktt4jDS0/77fBt0dLK3gIuO3tS
         iw3KXmMAj+ZU4l1LPb9AWJeU4Lf7UzzYSgx8eLoUwQ5dEFAAiEiYUMLDMZIysHEXsnkh
         7CIhNEJ8bmyllbq1YwkJ8JOMTTzFbaT0lFWyQOFNZlP0jQfZ7tf0jo2Q8StcNuqbvY0F
         qRZPyBgQzqpky3nblA46RnGpl8Iajpy4hg4ToZHZVTN4CnHv6Zryb1Jmie6ENR9j6Und
         lVMT4jklhtzyUbt2ekqa6xdwu/V60cKRQ57NXuiuxz2Gn9z3pp6vzaabYrwIXlDUvLkj
         kLZg==
X-Gm-Message-State: ACrzQf2gRT2fge4bgudoTYbwxnedQX0wO/DBRdiveIWkpBvgfQkXFmF3
        YTcLYB18W5jojDJiHUtO9g8d5GwCGoysJm4Ovfo=
X-Google-Smtp-Source: AMsMyM4wpdGeMMvg71oY+a/6SCIsiBEsaXv1cet+JHT87uV9K6xp3/eJdWBy5o7ltRI14xFiPCr7keF82xgoPKzTqLw=
X-Received: by 2002:ae9:ed44:0:b0:6ce:19bb:7780 with SMTP id
 c65-20020ae9ed44000000b006ce19bb7780mr17046769qkg.25.1664264103481; Tue, 27
 Sep 2022 00:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220818220245.338396-1-robimarko@gmail.com> <20220818220245.338396-2-robimarko@gmail.com>
 <1efe2f7d-05e2-6207-f4df-5b597d00c862@linaro.org>
In-Reply-To: <1efe2f7d-05e2-6207-f4df-5b597d00c862@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 27 Sep 2022 09:34:52 +0200
Message-ID: <CAOX2RU4vDC5emP=SA6cNmxyj=zBF+uWXSm9tNVytOhV16k--Dw@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] drivers: thermal: tsens: Add support for combined interrupt
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        rafael@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 at 00:49, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 19/08/2022 00:02, Robert Marko wrote:
> > Despite using tsens v2.3 IP, IPQ8074 and IPQ6018 only have one IRQ for
> > signaling both up/low and critical trips.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> I'll pick the patches 1-4 as soon as Bjorn gives its blessing for this on=
e

Sounds good to me,

Bjorn can you please take a look?

Regards,
Robert
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

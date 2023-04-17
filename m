Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE196E4291
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDQI0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjDQI0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:26:34 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010514212;
        Mon, 17 Apr 2023 01:26:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sz19so4878166ejc.2;
        Mon, 17 Apr 2023 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1681719987; x=1684311987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ikln/NaYz6UtRT1r/aDvlWV1lRzAzDmvUlab+NPGJmM=;
        b=Qyusl0kLbPHRBdinYJGat8swEUtZmlmuOKFcFhZlxIcDTKxGZxmgaXwCFsfm4B9mvU
         I+7FC0zawYvQ4rtoPuoFNqbhCQSgsqBvRiSAYHKki4SnNa/QaH68ihehmPtZn5Iyvnp4
         aU2cPoYrLOG5NFUqlzEENEFaEmFloEjNa6EDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681719987; x=1684311987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ikln/NaYz6UtRT1r/aDvlWV1lRzAzDmvUlab+NPGJmM=;
        b=DrNorHpewP+Xl9jV/u41RUMkf757Xd+Lq3kjGo4GfO5/IoXstC5UGHAoo0iZX0s4JI
         SW18bGnNf7sHg2QAIjGt88KqTyNvNHkQBfPDmUpkcuTZU2rV9VJO0kcZMckM/9IQ51ob
         SWNGOVIE7NECCNxIROUkG4r3ENvWLwFSGa+FdKvyXpbFyCjBgXJedMqih5E/Lpd/GLob
         d8we/PEBeB+7GH+WEtdjPdx1MJKVT0o03Td+YJW+cjkd5tnBcPTwkRU5R1heKPwbCqAx
         AHUr2losUqlMrHZG9q6zt9N4PyZMkZlUijjt29janfHAfSccH4t/u7otrBhQEsR6hq2u
         KMjQ==
X-Gm-Message-State: AAQBX9cJ0CrS3cC4Njkb7TsrINUsMWd6pSaRj8zr4dzVJ1T6xC+Uilw2
        /aXXlRppKImYvrRFCrt7fcuyM8lZrtUxDfjwbck=
X-Google-Smtp-Source: AKy350amKWlnDMF5fM0p5uQ4/lu7nNzaedfqrCiiti2CxfZBjqST2Vcd9EeS5+uCCbMBnP+x6wSD6Plx+v6gBmAxdv0=
X-Received: by 2002:a17:906:5e53:b0:94a:9f9a:b3c4 with SMTP id
 b19-20020a1709065e5300b0094a9f9ab3c4mr7063245eju.49.1681719987043; Mon, 17
 Apr 2023 01:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230413132627.3444119-1-lakshmiy@us.ibm.com> <20230413132627.3444119-6-lakshmiy@us.ibm.com>
 <5c043eeb-97c4-4666-9112-c13fefde81cc@roeck-us.net>
In-Reply-To: <5c043eeb-97c4-4666-9112-c13fefde81cc@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 17 Apr 2023 08:26:15 +0000
Message-ID: <CACPK8XeUnLd=Hi_mLD3Kd641DiJu_rnJW0zte-iJgM4q3wS6Lw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] ARM: dts: aspeed: p10bmc: Change power supply info
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, robh+dt@kernel.org,
        jdelvare@suse.com, krzysztof.kozlowski+dt@linaro.org,
        andrew@aj.id.au, eajames@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2023 at 14:43, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Apr 13, 2023 at 08:26:27AM -0500, Lakshmi Yadlapati wrote:
> > Bonnell system supports new ACBEL FSG032 power supply on
> > I2C addresses 5A and 5B. Update the device tree with new
> > power supply information and device addresses.
> >
> > Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> > Reviewed-by: Eddie James <eajames@linux.ibm.com>
>
> This patch will have to be applied through an ARM tree.
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks, I sent it as part of the aspeed pull request.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1D16C0CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCTI7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCTI72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:59:28 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A3F6A70
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:59:26 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5416698e889so211778487b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679302766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDWJfXvdVXROmcaw8SY1hPpIrcHxAiUQmw6S8AbfRjk=;
        b=hT8zarIC6fGYO8JaQq+5aomWL4kdHdFIMWxkLjsEAGQyCKEjeN0eO7gH7NWS01wmZG
         PeQq+pkGgtbGSr3a+xgj4NaPRyLVXeaLNmVgvXKoJUErSzDKgOKE0jBJqS4ioTI8SxO9
         jCV/35h90ss/uAbNVb+xTGp1qtDmKiXHgrxbompb+SYr1TbJuFQvj+r3lcVrIrjDllOn
         /r/7jFhcShwJnmUel5vb/6sKCAog8Y67DjWlTbSIiI9213OOkbgf2OFWehyfjp7HEUQc
         qFa0Xqk8iHu7qFsRXggiYwC//ZVuR62CX8sqHX3dQq80jXDgBpzLISQecktE92sJxuMY
         A47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679302766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDWJfXvdVXROmcaw8SY1hPpIrcHxAiUQmw6S8AbfRjk=;
        b=GvnjPlqpch8pAqu+ATi5rYh2IZxlgk+KuSGNvHr6QgtKrWI4mI6xeboxbzSupcKNI2
         YiYOg44wMEBS/GZes1jcTKEnMwFwDAmqyt9v2YrJXL1R3GQvZIOLhp9WHRe2lWQPx/F6
         62uMKRZRFwba/xRyFK/O++qZeGVxBd7GBajmvdK2/hJe9wm3qasXPF10v6mh4vQ/Cdgc
         VwgepcI5/v5/u9qdp0DdX6IdmUA571JnpbFB9rpCe5hz1REslbTF3RWChCNasZQhlmoH
         8PWMVkBzXYtsEvX9qnHzX8e+0a2Oqq80c4Zf7iZ2vOafYZAtsM7hk1EuAq4CkL8NfdBI
         Cb9g==
X-Gm-Message-State: AO0yUKV+KkaUDPOZ+IznRfnQ06M/RW/GUPuHHkPnxQTaU+eDPCLpRWuN
        HUqXnFw/7fyA3ioJeUZ4jKK6KUtXhtGJE5wrhT6htg==
X-Google-Smtp-Source: AK7set/+qbyNpMEXruJw4ZG3Cg+VGChyijWfL/S1Gs9k8SMXV8jldggbsN7+QdqY5qCobMSvgsRb6xs+dByuL5RTqzs=
X-Received: by 2002:a81:c749:0:b0:541:753d:32f9 with SMTP id
 i9-20020a81c749000000b00541753d32f9mr10038873ywl.9.1679302765812; Mon, 20 Mar
 2023 01:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
 <1679070482-8391-3-git-send-email-quic_mojha@quicinc.com> <CACRpkdbA27buNiOTz6ad4gyS4FCvcoYru6QB5k9Lqwiu72sf9g@mail.gmail.com>
 <20230320041019.5qs6qbztvv45pacs@ripper>
In-Reply-To: <20230320041019.5qs6qbztvv45pacs@ripper>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Mar 2023 09:59:14 +0100
Message-ID: <CACRpkdaWL_Rf+wbpLcAgr38Liy5_7J=UHrBbLqW-ZBkcpjvQKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] pinctrl: qcom: Use qcom_scm_io_update_field()
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 5:07=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:

> > Fine by me, but I want you to first consider switching the
> > custom register accessors to regmap.
(...)
> IMHO this is quite a significant effort, and given that the driver seems
> to be doing its job I'd rather see such efforts being focused elsewhere.

I think you know it better than me, if regmap is just going to clutter
the view the don't do it.

Regmap does have the upside of looking the same on all platforms so it
would potentially give less maintenance burden.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
for these patches if you need to merge them elsewhere, I can also
queue them if you ACK them.

Yours,
Linus Walleij

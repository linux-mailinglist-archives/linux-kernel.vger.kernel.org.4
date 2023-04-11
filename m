Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CCF6DDA83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDKMOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDKMOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:14:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4300B3AAA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:14:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l18so7264599wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681215243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hDe+eb+N5aBaVFbkdNkw9NWxh4mc4+HNanKKfElqBq8=;
        b=tAitHUirqTyd5v+Rab3tuHuLDcYaJ+SPtz0IShVP2Mecm4fWamzwo+pCajJR6gedVF
         pOwvGSMpkW66mT91DoCUmhKhwamkGneoiI+L8UUNhUfezOU0hZP0mbeuTlNOwT6hE3fR
         7wVn8qm5bnmZcsvJGIiLlNqgo0P3VaBYxx4OfF3yuFOUfMsz2uktMVHKFbDvmaoKkZu3
         15xMbqgMskKE4D0dB9BNSB2ZTWay3GImCl+0+efMgvudvBKz8/G92xdP1MfEamJbtDR0
         bWlP7GUIFogsXfc+jn6F7UezSbNPOZbv9OSM+nRno80CBAJDuP7AjvZgx7Ezd7vhaibH
         uwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681215243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDe+eb+N5aBaVFbkdNkw9NWxh4mc4+HNanKKfElqBq8=;
        b=nK76rx7T+zeJ2E4TbIzB2wOLZZpbOfnjznxXlNoSlSvl+Cqn5x8upS305yTBD/w4oi
         c8iKF6C+x2se3D1KKyLCs3uT7ZPvBFMy6JKVJlsRYMUvKZiqYs+ml6rteYy6KY/MS4p7
         3BWKIGywdCcrFYGs1csWXkThgYP4JVGXd/03vEyEDaZBZB+O/TM6/xosJM/sTZILiyAi
         cv7Sg601hvTxtnPSznYeR+3s6IBHL/iz9csfv7sKZ8AufaGarIT1VancBCkDXDXYtblW
         p72CdZIuSYpeeG5TuAS3LKhIvc68eClZNjwv4a+xKrW5wLS6dnIpeoMcgBHmdKbptaWq
         JGuw==
X-Gm-Message-State: AAQBX9cVtMQK9yIBOgA9QNPUa7bcYWAqVvIORT/zs9f1EB9v9GF2sDUk
        WZNIB5577duy/vnMYcA44Ga72Ba4iWYw2njhU8utsQ==
X-Google-Smtp-Source: AKy350aoFqvQaw/fPa9eUfklfZbl45HNWUhXjVdKPcKXHY6k5z/tDP93YK99N2m4Qr0jy9kI2wFhGlCcJPWlKkXEUqM=
X-Received: by 2002:adf:fe41:0:b0:2f0:2dbd:eb1c with SMTP id
 m1-20020adffe41000000b002f02dbdeb1cmr1233748wrs.4.1681215242599; Tue, 11 Apr
 2023 05:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230411072840.2751813-1-bhupesh.sharma@linaro.org>
 <20230411072840.2751813-4-bhupesh.sharma@linaro.org> <ff5691b4-df1a-57a8-6e96-f997bbe340f4@linaro.org>
In-Reply-To: <ff5691b4-df1a-57a8-6e96-f997bbe340f4@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 11 Apr 2023 17:43:51 +0530
Message-ID: <CAH=2Ntytn2GnBJkiZ4+xBf1X-fUUTD4iHWv-Sv66Jp1ePUDV3A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qrb4210-rb2: Increase load on
 l22 and l24 for uSD and eMMC
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 at 17:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 11.04.2023 09:28, Bhupesh Sharma wrote:
> > Increase the l22 and l24 load used for uSD and eMMC VMMC.
> > These need to be increased in order to prevent any voltage drop
> > issues due to limited current happening during specific operations
> > (e.g. write).
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> You could have simply squashed this into the patch where
> you enabled the controllers, so that that commit works
> reliably for e.g. bisect

Yes, but Bjorn asked me to send this separately (via irc).
I am fine with squashing this with the previous patch [PATCH 2/3] as
well, if Bjorn is OK with it.

Thanks,
Bhupesh

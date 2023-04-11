Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98046DDE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDKOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjDKOc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:32:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BC040E4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:32:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso11140773wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681223571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl1AL+4/9PrAyu2t6M5fCbtCFLSTLudMZGWKn5iwi08=;
        b=cOg1BxwlZou2nKMNK8+W+eLzUaASk6OLwOCEKyVd0ojR/I/27tfxjn0yXKVwj/GCGe
         Z9mWSdCns0pRmm5gmbJ6aEZ112/jqtVU8I+hDb7gotuwnwV53msqpsI1/0OC6wWxuvlE
         RTXjrjUSmCkfOTiAgB5i2Ie6mdF19aCTs8PKOnHL0Qkyvvg/5T8FN6jechzg7gS84cAD
         9HEm1BlyaPZ9HO7JryOP4eSKQnqUqc0ZbWNRy5gvTK8kIuzV6Sb5Bv/f9OrkuAqzOsM5
         UcQ9FFHjJX0dKFR23JHkmOCf5WwO2T8azPkg3xnr9BAgnEbrU+chWFWa5/6+KQHdBR2K
         1YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rl1AL+4/9PrAyu2t6M5fCbtCFLSTLudMZGWKn5iwi08=;
        b=bFtFPsUipZrmYFmxkV7t7+/B7FRzdBWm718wVOYzTGtvTYuJAFyyTDgf9Gk7jd/vIn
         oGMTqFaUu+D7JDZIqXCrbCKltMn9G0ye0WKLC2YggnleK5Ccbphbp+DMSAHlh+vCl5Wg
         zzFLjQKvsYx3kIS+Kj4ybzB9n3XuICZjransCv2+qpzqJHhJDPmXicc1xutJZl7LgWiX
         CQT9QuaJFGTKJL9CfFkX0aXiYznEPKyY2zP5SCwkAbxpDJYmrXWUm9UBeJHq0IuD138I
         d6nL3GDsEFj87+K8raDP3sFGgvEj7kn4K57iRDI5yqw7CZ09Tt7+B8cfG+WgP09tScQ8
         5VjQ==
X-Gm-Message-State: AAQBX9dm6fy4PUqmKOPRs+GNOlgyPdHgyWux+2r9vUiepAYcexPiIp/n
        cCUE5w+WUhbOwELk/lGzkeTOtESWqX+wt9Iim5tA6g==
X-Google-Smtp-Source: AKy350aG/I0fGJlNxt2sYUNaG5F2QtH8OK/Q3bto6+AxGBsyCa8HZtGFbagxpPLKph5aiDE4cqQkN+taHaxQvEGUDUM=
X-Received: by 2002:a1c:770c:0:b0:3ed:526c:25cb with SMTP id
 t12-20020a1c770c000000b003ed526c25cbmr2414127wmi.8.1681223571525; Tue, 11 Apr
 2023 07:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230411072840.2751813-1-bhupesh.sharma@linaro.org>
 <20230411072840.2751813-4-bhupesh.sharma@linaro.org> <ff5691b4-df1a-57a8-6e96-f997bbe340f4@linaro.org>
 <CAH=2Ntytn2GnBJkiZ4+xBf1X-fUUTD4iHWv-Sv66Jp1ePUDV3A@mail.gmail.com> <20230411124254.r4sk7fn4wdrdt6qy@ripper>
In-Reply-To: <20230411124254.r4sk7fn4wdrdt6qy@ripper>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 11 Apr 2023 20:02:40 +0530
Message-ID: <CAH=2Ntz24Tn_Vj=7Z6x_Br+CLVyXQ=DSPeZ5WOAMhhd6JD+Biw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qrb4210-rb2: Increase load on
 l22 and l24 for uSD and eMMC
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 at 18:09, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Tue, Apr 11, 2023 at 05:43:51PM +0530, Bhupesh Sharma wrote:
> > On Tue, 11 Apr 2023 at 17:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > >
> > >
> > >
> > > On 11.04.2023 09:28, Bhupesh Sharma wrote:
> > > > Increase the l22 and l24 load used for uSD and eMMC VMMC.
> > > > These need to be increased in order to prevent any voltage drop
> > > > issues due to limited current happening during specific operations
> > > > (e.g. write).
> > > >
> > > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > > ---
> > > You could have simply squashed this into the patch where
> > > you enabled the controllers, so that that commit works
> > > reliably for e.g. bisect
> >
> > Yes, but Bjorn asked me to send this separately (via irc).
> > I am fine with squashing this with the previous patch [PATCH 2/3] as
> > well, if Bjorn is OK with it.
> >
>
> I was trying to say that I was fine with you just fixing the small thing
> I had asked for and then you could send a separate patch for this when
> you found the time.
>
> I can squash the two while applying, unless anyone else have any
> concerns with the patches.

Sounds good to me. Thanks for your help Bjorn with squashing the patches.

Thanks,
Bhupesh

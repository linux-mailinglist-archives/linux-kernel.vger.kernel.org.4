Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1785461F606
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiKGO3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiKGO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:29:37 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3A01FCDB;
        Mon,  7 Nov 2022 06:24:55 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so6611356otu.7;
        Mon, 07 Nov 2022 06:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG4UQVZgFzf5wzCzoJA49RijDyqcF2v5Wg1wz+or46w=;
        b=DuuD8pG5alSGOKfFryOtNi6kxRJuDHNQZhwdHObMWH6AinCIul5RLrmDXBV8fSaSbG
         DDWqGSw5uJeTFgGLvBa4mSdEkcOPUDPsN64segrwzD0nhTCl3p0a1Ci4Uq+ZddRS644S
         9GGCrufcXNzS0rBP4ARHU2voJ7N0/rjpccMgJDKAirZClEqT13BFVcI2mlaXVmOKVpUR
         yEUcevMNEMAi0cPGp70O5b6WZAi5SLssW6CwD7+kEfMDE1gsmH9IVvnACDikAy5LVlBu
         yUnPRF9w1LP/ww3LWO9Rd+9ert42PvZ1j9bfwjyPtWFeNY0H/BuIsOgML3qDRcnWqhqt
         VUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IG4UQVZgFzf5wzCzoJA49RijDyqcF2v5Wg1wz+or46w=;
        b=GLMOAYtHG2BYnBccYPiwJMCLUvvR5DkYjN5J5x/7YOlUGHQA9KWFtZiPRmXu963+V1
         spcidoDLYolT+ThhvIsbmmj13sCP/V2vZgoFs9eb4mNjwdPfCOytHYW14l+7KK/p8hxz
         zcpv3E+FlSaOFl3zO9c1PNnXbwzAKbd8pUyghvqAAl9AdMRdVWNQwprW3PpsmeLX8Va+
         FLCWuGPlDRW6g14QSVgW57hDrwqKAO+s3UmyHevVjYds6+A0WbrJuthaur8zxW4wCFJW
         WBQC38JMYDuNj7LI2uWr35MA/bvCNLMawUffDn7ZnCrj/zPj6zkqAlimniW0dO3dsgJQ
         ZWcQ==
X-Gm-Message-State: ACrzQf0Kh3CKg3H+mJlFBrVNkR/BKGXQXvQzGtVsduNr+oH60N6SFqoV
        mPSn6J9UPyaRoq3sBVTOfbq+wda2q1fu/5EFpQw=
X-Google-Smtp-Source: AMsMyM6s/NUbomfeK10UhYLZsIsefU9QwYjEfjYygF9tunUt3jy5PYwg8zkHinaXgQaqjcDvBGpx4Ay7pq1oyZUee4o=
X-Received: by 2002:a9d:f44:0:b0:663:bfe6:2a6d with SMTP id
 62-20020a9d0f44000000b00663bfe62a6dmr24418402ott.214.1667831095098; Mon, 07
 Nov 2022 06:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20221102155558.1895829-1-dsankouski@gmail.com>
 <20221102155558.1895829-3-dsankouski@gmail.com> <1a8bab07-46c4-1585-45ff-8780c02afd4e@linaro.org>
In-Reply-To: <1a8bab07-46c4-1585-45ff-8780c02afd4e@linaro.org>
From:   Dzmitry Sankouski <dsankouski@gmail.com>
Date:   Mon, 7 Nov 2022 17:24:44 +0300
Message-ID: <CABTCjFBth=jON-uuMU54cQi3zDcGYtGMbpaKitc1WHx+ciNiRQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] arm64: dts: qcom: sagit: add initial device tree
 for sagit
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

Is the master branch of
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
proper rebase?
Or do I need to search and apply device tree doc patches somehow
before running dtbs_check?
I rebased on linux-next/master, and my dts is ok.

A lot of warnings for msm8998.dtsi, though. I think it should be fixed
in a separate patch series.

=D1=81=D1=80, 2 =D0=BD=D0=BE=D1=8F=D0=B1. 2022 =D0=B3. =D0=B2 22:20, Krzysz=
tof Kozlowski
<krzysztof.kozlowski@linaro.org>:
>
> On 02/11/2022 11:55, Dzmitry Sankouski wrote:
> > New device support - Xiaomi Mi6 phone
> >
> > What works:
> > - storage
> > - usb
> > - power regulators
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
>
> (...)
>
> > +
> > +&blsp1_i2c5_sleep {
> > +     /delete-property/ bias-pull-up;
> > +     bias-disable;
> > +};
> > +
> > +&blsp1_uart3 {
> > +     status =3D "okay";
> > +
> > +     bluetooth {
> > +             compatible =3D "qcom,wcn3990-bt";
> > +
> > +             vddio-supply =3D <&vreg_s4a_1p8>;
> > +             vddxo-supply =3D <&vreg_l7a_1p8>;
> > +             vddrf-supply =3D <&vreg_l17a_1p3>;
> > +             vddch0-supply =3D <&vreg_l25a_3p3>;
> > +             max-speed =3D <3200000>;
> > +     };
> > +};
> > +
> > +&blsp1_uart3_on {
> > +     rx {
>
> This is a friendly reminder during the review process.
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
>
> Thank you.
>
> 6.1-rc3 is not a proper rebase... You *must* include maintainers'
> entries. This *must* align with stuff has Bjorn. Also I expect it passes
> dtbs_check on stuff in the next.
>
> Best regards,
> Krzysztof
>

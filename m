Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9E560EA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiJZUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiJZUj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:39:57 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679CA167D7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:39:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z192so6343988yba.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daYBwE/xgD9h3LwP3sciyNnst9YWMODARklElncCAU0=;
        b=g+XJ8M3/27LzItdcyttOglsv/BP41vBwfOCU5njWntm42Cna4B84KFt9JxXFA81WGW
         oHv2ipaiOxp9I8LqN3D7Awo6fBugGJBbVkfVkTbVqaZ/3actbpgSe7WtHoh8jZPrJTn+
         /u6dDMcBuT8Td/kDRfiqCeWPMgCJxS4jWwmyIPOFaly/4MYdhJsau0a8W6BGFBnebJRr
         HYclJfR/ZmJF863HTkF6qPjFk4ffS4z686Uy0HyGzJx9Y6Y0XX+Z36wSJ7HVnf892Dab
         0pISkacDQ38x7TqCs6phTjrqCKgsq2G3l85DAXYkZhLR7LuU5KrHdMx2ndDyo5T0K0E2
         tD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daYBwE/xgD9h3LwP3sciyNnst9YWMODARklElncCAU0=;
        b=sXPmQCacoKYm6h7xvngQX2Bu+bSxzp2HX+8pl8557KzX7pGtljPBO73s+woYHuEO9w
         F4wWhwFxsXIqhnbJksTLDjfdp8np3wcEFmLr2i+lWCGRqVSV3Z4ok71HDfOvj3zBWpDl
         DuTl7T6zo0+s6wriIx/egaNl6jDkRvYOJXypsrUNfVgU8IdsAa4m26L2zW6SPb6tqRcT
         KlPn5BFmlrnmzIKsrY75jFKNvAcyop6H1JqYgFKzGlr0S3II1R/MqRlnhXI0tBGtgnGd
         RhxnERI5/DOJEuQ/wNNZLLdjpwCo3A2dWrKoydQg1ETdcajMDcw7vkpyEBjhfxjb+V+a
         MsTw==
X-Gm-Message-State: ACrzQf15FDZJp0zDLBlj4e3Tgi99QSxircRBgMpMx9HvChGnCBRVVIHc
        H3oiSNCWDRsqfBNq4hqWrbFISo+Nzcx2GjUEo9uNug==
X-Google-Smtp-Source: AMsMyM6NoeDMXQ0P7X/sORDu/SfdbmYsySWoMWI2VrXjhxme//k9u7J+bBBfL+Ts1do43c7CJ2map1JSsuDKLkwe6Yw=
X-Received: by 2002:a05:6902:724:b0:6c0:1784:b6c7 with SMTP id
 l4-20020a056902072400b006c01784b6c7mr40939021ybt.15.1666816792883; Wed, 26
 Oct 2022 13:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-5-quic_eberman@quicinc.com> <56a47a6c-29b9-b8f3-e39b-a5841ddf7394@linaro.org>
 <e79513b9-3bbb-851c-6e46-92c043c8d1e7@quicinc.com>
In-Reply-To: <e79513b9-3bbb-851c-6e46-92c043c8d1e7@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 26 Oct 2022 23:39:41 +0300
Message-ID: <CAA8EJpoE5LPD531bCYT02zhUXH-6b59MkmQ=jwCHCqebEZ=75A@mail.gmail.com>
Subject: Re: [PATCH v6 04/21] arm64: smccc: Include alternative-macros.h
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 at 23:24, Elliot Berman <quic_eberman@quicinc.com> wrot=
e:
>
>
> On 10/26/2022 12:46 PM, Dmitry Baryshkov wrote:
> > On 26/10/2022 21:58, Elliot Berman wrote:
> >> Fix build error when CONFIG_ARM64_SVE is selected and
> >> asm/alternative-macros.h wasn't implicitly included by another header.
> >
> > Please include the build error into the commit message to help anybody
> > looking for the solution for the same issue.
> >
>
> Now that the gunyah_hypercall implementation has been moved to its own
> module, this change isn't needed because asm/alternative-macros.h got
> implicitly included now. I can drop this, although not sure if we think
> it's still correct to have it?
>
> After I got rid of the other header files, for reference:
>
> In file included from arch/arm64/gunyah/gunyah_hypercall.c:6:
> arch/arm64/gunyah/gunyah_hypercall.c: In function =E2=80=98gh_hypercall_m=
sgq_send=E2=80=99:
> ./include/linux/arm-smccc.h:387:25: error: expected string literal
> before =E2=80=98ALTERNATIVE=E2=80=99
>    387 | #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl
> __arm_smccc_sve_check \n", \

Please add this message to the commit log.

>
> >>
> >> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> >> ---
> >>   include/linux/arm-smccc.h | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> >> index 220c8c60e021..6a627cdbbdec 100644
> >> --- a/include/linux/arm-smccc.h
> >> +++ b/include/linux/arm-smccc.h
> >> @@ -383,6 +383,7 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0,
> >> unsigned long a1,
> >>   /* nVHE hypervisor doesn't have a current thread so needs separate
> >> checks */
> >>   #if defined(CONFIG_ARM64_SVE) && !defined(__KVM_NVHE_HYPERVISOR__)
> >> +#include <asm/alternative-macros.h>
> >>   #define SMCCC_SVE_CHECK ALTERNATIVE("nop \n",  "bl
> >> __arm_smccc_sve_check \n", \
> >>                       ARM64_SVE)
> >



--=20
With best wishes
Dmitry

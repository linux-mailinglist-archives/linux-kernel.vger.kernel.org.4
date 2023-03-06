Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDBD6ABD2E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCFKrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCFKrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:47:32 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678D20D34
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:47:30 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id x6so9153081ljq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 02:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678099649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQCRshdQg1v0si9EwPt4TtPtYK6E589Q6hmnpjPICm4=;
        b=sJQ7h5p47zK/Pls6m/WmYq2eD0pdis9NeiPwQe7r/SnBuV7R7rJQuFOvO5DFiVmboN
         ZypGPjScBG1NC09CChgOEVSDRCdJOzI3Qg4HdTqPz9W3y4tcv20ohLEaWZ92fv12932K
         J0Cs/KEov+jIPfJg3o8SoO6HNu8pjtE0hEHvCbHX+r28Fr1qqLr1kr7/cIS10RW0FjGi
         JtmULfGos2E5BbjrYTW2NEGOPbt5Se709hErNL6qKSKSXlkFDFKl3sM8MaCjXmTDq736
         FeOxcS2ZlNobxYKOil8NbhrAWTUghZi1LEiYsvoeYunEtNtqyssCaZeytnvcAvnnbaMC
         GVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678099649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQCRshdQg1v0si9EwPt4TtPtYK6E589Q6hmnpjPICm4=;
        b=YS6BsH6mvNq5d1geAESRBhvm/TI5onBVc2b0sDkcv/dYjYITrxZuPsbNMTVRwkKYP+
         tblSXlXvS/Yri1EFdI0iBbaisQGUUY11fDY5UXoEEPtd/cnsPSw561TVQ0dP4bdTGuvx
         TMYArkH4usFreJnnKI7SAxNQeWH9pAns35WpTHknPRFGHbTnkvCz99X3I3hY4afRSZHE
         j18rJg1H0HBLMo4UhzSgnjciqkfZbgLQrE7revoaa46dlN3o8mQI6a2SWL0P7wPxBePd
         Ew9jF7KMUErPbxQzpn7KdBbBWhT9t4PUOIYIiwt56ExBcgkrcbeTeso7Gvev6XOpWIzH
         RNqA==
X-Gm-Message-State: AO0yUKVQAUkf1pfCI89ugmTbJFcs0IrqMdYynnHyZoyfyHdkPeSnWXge
        8V8dp004LrcfxRk6XnQjn2VtbuYa5w4vgY929QF81w==
X-Google-Smtp-Source: AK7set/OFxw/Sf4dXegmBrjGIG9BKjWy0BEU/Sp7Ch4KHJbWekGeicsrSc5ir8fOPijVjDZuEyFCPbZGFnvS2ni2cuI=
X-Received: by 2002:a2e:593:0:b0:295:b0cd:523 with SMTP id 141-20020a2e0593000000b00295b0cd0523mr3059795ljf.6.1678099648880;
 Mon, 06 Mar 2023 02:47:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677063656.git.viresh.kumar@linaro.org> <CABymUCMhoKoFHy8K6-ohrcAbyTpDe0Hig3oUM_wH4Db0-9yx+g@mail.gmail.com>
 <20230224021713.stpcykx2tjkjwyti@vireshk-i7> <Y/hyf+/EqEeTu436@niej-dt-7B47>
 <20230227042349.3p2ijo6s6yyqc267@vireshk-i7> <CABymUCNBkr_65JHNVfbUGjxs6rhnj=eUyZ+5j6VtiDwqzLYtcA@mail.gmail.com>
 <20230227092953.ekh72r5h6xcqgusn@vireshk-i7>
In-Reply-To: <20230227092953.ekh72r5h6xcqgusn@vireshk-i7>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Mon, 6 Mar 2023 18:48:09 +0800
Message-ID: <CABymUCO4Gb-vALx=qa1q=QNfTJWoqNpT2r3J_xHxhGk7FZE0nQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] OPP: Simplify set_required_opp handling
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     cw00.choi@samsung.com, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
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

Viresh Kumar <viresh.kumar@linaro.org> =E4=BA=8E2023=E5=B9=B42=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=B8=80 17:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On 27-02-23, 17:21, Jun Nie wrote:
> > Sorry for not expressing it accurately. I should say devfreq devices
> > pointers, just
> > devfreq_virt_devs vs genpd_virt_devs. Then you know why I add devfreq-d=
evs
> > dts nodes below.
>
> Won't something like dev_pm_opp_set_clkname() would be enough here too ? =
We
> already do this kind of work for clks and regulators.

Thanks! It is a possible solution. I will try to spare time on this as
higher priority tasks
are on my list.

>
> Having power domain specific information within CPU nodes isn't a require=
ment of
> the OPP core, but the general requirement of genpd core instead.
>
> --
> viresh

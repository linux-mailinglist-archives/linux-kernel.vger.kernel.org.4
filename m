Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86671952C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjFAIPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjFAIPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:15:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCC5C0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:15:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af28303127so7299611fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685607316; x=1688199316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wwwjM9P/GD9y2WtF65nLtVcIMEiwxXul9Ob8jZmYYk=;
        b=XI3ldMgL0wgSZCxVcqoTaJKj8OW3UmqWeaQ0GC3A0n00XtrjXX71IOLLTytWsCZmfS
         ZBhojKovQxnkZWjbYM3OqfmBKiYKw67kSgXDGgx9OekKZHP2vCfF3/H9pEBNED5pR+B0
         HbivpF/e5u9dbmyoIU3uFFpXTlxwkzWCyfytvv3dAN615J781KE7nUQiSrM7qQhpXFqR
         q5jlql1mv1I2hjm6ogx+fYQuBBAxwSqZR6X3weutBUdTXWEGYyWu/8kfEDub7nqAptrc
         WlkYyRBO8W1cvyn3Wg/AdZHc5849fmMfy/8AF4M2JvCJWZ47dBOsFCZdLkBPM/xywO2s
         Lgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607316; x=1688199316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wwwjM9P/GD9y2WtF65nLtVcIMEiwxXul9Ob8jZmYYk=;
        b=coxGDmQjR7m4Ig/U/mGv8cITFNbfE4julyDEHUPb0P+OtDgpC/STsj8iRoBCXxZcTH
         RTGk2ZhC2DrAToOneyBJ5nKfdJdwdwdRsaplnLi1oadweyiSdJssSpwTVMdxO3W17er2
         0r4883QHz1oQvLf+SAoraMFmCZZWVG3dZKwY5Z1eJU+QuHr0lsFxGJXhxoFXXYpMzLV4
         8QCYihEkNbYiFeIOdmRO4/29jwW1G+dcYR47vI1D9Q8QsaVfmtwAAmIo/GOthdAtrkWj
         Kq8ONTwc9csXb7+0RazIORaLDySwZdJ4w5/Yc9juJdeaWZFygl4X4b4J1gejXVCuOlP8
         M/EQ==
X-Gm-Message-State: AC+VfDxXISzsm6kcRmLby0+1X8ax7fhIMLYtJWdE6nSvMIoMQdDJp54D
        CKitYZtK+lqghIIhVGEf3hiTLg==
X-Google-Smtp-Source: ACHHUZ6iiQPR2tf93aAvw7Aij8815QXY9Vq0T9piVYxnhMCB9kcVvtlaaPViZzJ/DeRWFf/5vVtajg==
X-Received: by 2002:a2e:9dc1:0:b0:2ac:819f:f73f with SMTP id x1-20020a2e9dc1000000b002ac819ff73fmr4470033ljj.20.1685607316119;
        Thu, 01 Jun 2023 01:15:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id v12-20020a2e990c000000b002af01da6c67sm3692769lji.32.2023.06.01.01.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:15:15 -0700 (PDT)
Message-ID: <e98a2901-7ad4-5a1f-5739-64750836d396@linaro.org>
Date:   Thu, 1 Jun 2023 10:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/8] Flush RSC votes properly on more RPMh platforms
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>
References: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
 <f5875c10-21c1-43b6-4ce6-25b968588412@linaro.org>
 <CAD=FV=Um8U2MQsrv+ngQg_h-aQMi5_yy6Lrj3ovr7eV1PC+Wnw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAD=FV=Um8U2MQsrv+ngQg_h-aQMi5_yy6Lrj3ovr7eV1PC+Wnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.05.2023 23:45, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 31, 2023 at 7:26 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 31.05.2023 15:22, Konrad Dybcio wrote:
>>> As pointed out in [1], the Linux implementation of RSC basically requires
>>> (even if not explicitly) that we point it to a power domain which
>>> represents the power state of the CPUs. In an effort to fulfill that
>>> requirement, make it required in bindings and hook it up on all platforms
>>> where I was able to do. This means all RPMh platforms, except
>>>
>>> - SC7180
>>> - SC7280
>>> - SA8775
>>>
>>> As there wasn't an idle-states setup (which may be on purpose for CrOS
>>> devices, certainly not for Windows SC7[12]80s) that I could validate.
>>> (Doug, Bartosz, could you guys look into your respective platforms of
>>> interest here?)
>>>
>>> This series also adds support for idle states on SM6350, as I was able
>>> to add and test that.
>> I noticed that 7280 is WIP:
>>
>> https://lore.kernel.org/lkml/20230424110933.3908-4-quic_mkshah@quicinc.com/
> 
> Right. For sc7180 Chromebooks we don't use OSI (OS Initiated) mode but
> instead use PC (Platform Coordinated) mode. As I understand it, that
> means we take a different path through all this stuff.
> 
> That being said, in the sc7280 thread you pointed at, Bjorn and Ulf
> said that we could use the new device tree snippets for sc7280 even
> before the ATF update. If I'm reading the thread correctly and the
> same applies to sc7180:
> 
> 1. New DT plus firmware that doesn't support OSI - OK
> 2. New DT plus firmware that supports OSI - OK after code changes
> 3. Old DT plus firmware that doesn't support OSI - OK
> 4. Old DT plus firmware that supports OSI - Not OK
> 
> For sc7180 Chromebooks we'll never have firmware that supports OSI.
> That means that, assuming I'm understanding correctly, we actually
> could move the DT to represent things the new way. Presumably this
> would be important for sc7180 devices that originally shipped with
> Windows (I think support for one of these is underway).
It's even merged now!

Yeah, AFAICT all you said makes sense

I don't however know how you tell RSC driver that your platform is
going to sleep when using PC mode..

KOnrad
> 
> -Doug

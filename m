Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB3D7072F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjEQUZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEQUZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:25:06 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2247AA9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:25:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ac785015d6so12322901fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684355103; x=1686947103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9e0TlWFJ4jnKLP48QttQ1EhOBYVUZ/hqG3PCu64KDjk=;
        b=Nm5Z48j4L7l8aONmFdB0bPU503Vez21R0xjklG6FwEm856DgC0jTlLh+LlXqicg9qu
         4QiujrQQnAlQmpGznZRLaJS0taDoMnPZF0fgC593g6VuQpcatPf44UBi+XCH2pFTvlX2
         BC2ORFGHCscs4pmVjFlnUMH4E62Ct1kBs/t0HnljUAZMpgH3Y1zGadvgLslKTGJSO1Fh
         cwKFiji4dhv5uhD+JJ+BkPgOCwIMJ9CpQgVWzJiohylg3lr0ZloBKQIepl1KEjkKxbxc
         58fIpFL6oCDH/jROlikNU312tkq1IHEJUIE6DbHep1CHdHAyhU326KvOo9K9d+6NhEZL
         Z7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684355103; x=1686947103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9e0TlWFJ4jnKLP48QttQ1EhOBYVUZ/hqG3PCu64KDjk=;
        b=kVOmkHnadfw+BN4ZYBCuDy67tnh4GlXiv6damqAl5jE/zwFngiyJ2MhoCNuOifnJkF
         C2/kRXgf6xpx/ItybIjSYYRA7cZIQKns/MRCcx0n26qxXdux7cw9/RoVfJt40Jcz1cew
         9YDjK1jiL4W+MuTXnQsk0DjiBy/6qWAGNfZupyFUz94uAPvOjm/Ok6qRzyite+fcmZmp
         Rn/LzAGu2okypha7eiRaypBl3hZ3getYXp1Q/Zfn9GC0qJA1UnXL/IX7ZtwSV9r/YPnK
         F4AAPCxBzpPTkEQI4EdUP7agaeLEW4zTbfuAtgr+uXwchjIDa8cAXyOJ2k7grvik/HHg
         6GnA==
X-Gm-Message-State: AC+VfDyGubD7clZpoaInTDqJytL/qHdeDqq8y37K0k5J5fBZcIgrjfdo
        /wzEaBTpEo099sy0vA26twcGKg==
X-Google-Smtp-Source: ACHHUZ6AK0LriX0PjEwJvvd7rb1hrYTCrIWnDjpQQbNIWK8Yk/0ibBUzwrlcrCwrjv2/dIYoYawb3g==
X-Received: by 2002:a2e:7a13:0:b0:2a6:1682:3a1e with SMTP id v19-20020a2e7a13000000b002a616823a1emr9930406ljc.31.1684355102763;
        Wed, 17 May 2023 13:25:02 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id s23-20020a2e9c17000000b002ad90280503sm4079780lji.138.2023.05.17.13.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 13:25:02 -0700 (PDT)
Message-ID: <763ab7b6-9e97-a2ee-2d49-5b666ca63941@linaro.org>
Date:   Wed, 17 May 2023 22:25:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/18] Venus QoL / maintainability fixes
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        stable@vger.kernel.org
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <f9904e82-4756-2add-3c7e-e019ce966515@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <f9904e82-4756-2add-3c7e-e019ce966515@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.05.2023 05:01, Bryan O'Donoghue wrote:
> On 04/05/2023 09:00, Konrad Dybcio wrote:
>> Tested on 8250, but pretty please test it on your boards too!
> 
> What's the definition of test here ?
> 
> I ran this
> 
> ffplay -codec:video h264_v4l2m2m FantasticFour-ROTSS.mp4
> 
> and this
> 
> ffplay -codec:video vp8_v4l2m2m /mnt/big-buck-bunny_trailer.webm
> 
> on db410c with no errors. Then again I applied and disapplied the 8x8 264 fix to that branch and saw no discernable difference so I'm not very confident we have good coverage.
I don't think we have any coverage at all, especially considering
there were 1 or 2 patches fixing vdec not working at all in the past
few months.. Maybe CrOS has some internal pipelines for this.

> 
> @Stan @Vikash could you give some suggested tests for coverage here ?
> 
> @Konrad - get a db410c !
Don't think they're even made anymore!

> 
> My superficial first-pass on this series looks good but, before giving a Tested-by here, I think we should define a set of coverage tests, run them - the upper end on sm8250 and lower end msm8916 "makes sense to me"
> 
> 20? different gstreamer tests at different formats and different sizes on our selected platforms db410c, rb5, rb3 I have - also an 820 I haven't booted and an enforce sdm660.
> 
> Which tests will we use to validate this series and subsequent series to ensure we don't have more regressions ?
Personally I've done:

- boot and check if venus still probes and doesn't shout in dmesg
- decode and re-encode a H264 file

which is far from perfect..

Konrad
> 
> ---
> bod

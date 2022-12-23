Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC5F655033
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiLWMPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiLWMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:15:37 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A7923D;
        Fri, 23 Dec 2022 04:15:33 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id v11so4800636ljk.12;
        Fri, 23 Dec 2022 04:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5kHe4kFKe8GciyEd0D6yxSAat+6tJA2KlX+zERnbZM=;
        b=JbCzdsM2tjp/t+U1y9Uc7NbFga0zKTuD7/qYbtgv8UBf1o7AMtZuB19gvXSDXg3q7G
         4kyl/01zusivdIf07cOAv+wObyjy9K4zkdQYcg9CZihmigK8pRkaGG87jt7qb0HzQLny
         1eAYThtFX6/mpvIZPoXNff+Ln8Th0BRsQ2KoSm5GODsoE8upEMYAZzoGoKh/IkVw2HfZ
         DfX/Cs4+GcX/KSemC4ZQO3mZuK4mVVEGwb3MqSYsZ8nu9vFg+awCSPxGXgNSBE9apFya
         +oekj3bvQAraJvqbbRIHrccZt3U9jdAf1s4DULioWPxser1gDcA8kLIvg+t4EHiIyAAF
         ZYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5kHe4kFKe8GciyEd0D6yxSAat+6tJA2KlX+zERnbZM=;
        b=gWh6gsdUljjir4zSBlQpyADpMgtOnDhAFyt9J32cvGa2qdU1QK2El/4f2ZFeepl4GD
         Df3OUTahG2912ATO8biYR0j1iNINbuiJj9TJMRzfiVK+67l30X5iR0vQDUaEXCN4/9PB
         SLeFXhqaDIqstABJmzGdcwycRpqZdpJz9pdt4VPboamqiNr/SwVrCzbGe70sy1Ok50x+
         hMdvGjdZyjFwv1p/CZAbfeRQJ3pusp+iQlnYO+ELDtv+DvHJRVrTCs8svuqNV4nuY5wI
         LxDdsVIbH0YKKbDYzkgJwbRMV15XEYzRDFBLxZtgj640E3c24zJTU7jJyVCV6px1N0yL
         3FXg==
X-Gm-Message-State: AFqh2kr6cXmsm8xv5hE+sR18+e+xBNg+ucogrf0NhOIApj2YiqRXD1gT
        CZr7bAUfkChjkmq0C9woirc=
X-Google-Smtp-Source: AMrXdXuFncqdpV7MwxrbpwS9opnJzxQzZgiu2wJohaBy5psBQl9VkPk8qgO3HzlJODeOzfBeXB4TDA==
X-Received: by 2002:a2e:3a15:0:b0:27b:4a50:b85b with SMTP id h21-20020a2e3a15000000b0027b4a50b85bmr2309038lja.29.1671797731691;
        Fri, 23 Dec 2022 04:15:31 -0800 (PST)
Received: from [192.168.2.145] ([109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id u12-20020a2e2e0c000000b0025ebaef9570sm400766lju.40.2022.12.23.04.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 04:15:30 -0800 (PST)
Message-ID: <a64e2aea-2e06-a72e-5ced-a86de4458c61@gmail.com>
Date:   Fri, 23 Dec 2022 15:15:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 21/21] staging: media: tegra-video: add tegra20 variant
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
 <20221128152336.133953-22-luca.ceresoli@bootlin.com>
 <30e6b040-aa82-f6a3-1ff6-baa2c0dcb0e2@gmail.com>
 <20221222100341.5882c19c@booty>
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221222100341.5882c19c@booty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.12.2022 12:03, Luca Ceresoli пишет:
> Hello Dmitry,
> 
> On Wed, 21 Dec 2022 00:40:20 +0300
> Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> 28.11.2022 18:23, Luca Ceresoli пишет:
>>> +static int tegra20_channel_capture_frame(struct tegra_vi_channel *chan,
>>> +					 struct tegra_channel_buffer *buf)
>>> +{
>>> +	u32 value;
>>> +	int err;
>>> +
>>> +	chan->next_out_sp_idx++;
>>> +
>>> +	tegra20_channel_vi_buffer_setup(chan, buf);
>>> +
>>> +	tegra20_vi_write(chan, TEGRA_VI_CAMERA_CONTROL, VI_CAMERA_CONTROL_VIP_ENABLE);
>>> +
>>> +	/* Wait for syncpt counter to reach frame start event threshold */
>>> +	err = host1x_syncpt_wait(chan->out_sp, chan->next_out_sp_idx,
>>> +				 TEGRA_VI_SYNCPT_WAIT_TIMEOUT, &value);  
>>
>> You're not using the "value" variable, it should be NULL.
> 
> Ah, sure, good catch.
> 
>> The "chan->out_sp" looks redundant, it duplicates the chan->mw_ack_sp.
> 
> I agree it is redundant and can be improved.
> 
>> AFAICS from the doc, T20 has two VI channels, and thus, two mw_ack_sp,
>> like T210.
> 
> I'm confused by this. In the current driver, each VI channel has an
> array of 2 mw_ack_sp, the second of which is only used the ganged
> CSI ports. I have no docs mentioning ganged ports so I don't know
> exactly how they work and whether T20 might need more than 1 syncpt per
> channel or not for CSI. Definitely when using VIP only one such syncpt
> per each VI (or per each VIP, as per your reply to patch 1) is needed.
> 
> Bottom line: I think I can simply remove the out_sp and in the VIP code
> always use chan->mw_ack_sp[0], and document that it's what is called OUT
> in VIP terms.
> 
> Does this plan seem good?

Older Tegra VI doesn't have ganged ports, but two memory/CSI channels.
It feels to me that Tegra VI can capture both channels independently,
though downstream driver stack used only one of the channels, IIRC.

There is a VI header file from nvddk in downstream kernel, which is
pretty much the doc by itself.

https://nv-tegra.nvidia.com/r/gitweb?p=linux-2.6.git;a=blob;f=arch/arm/mach-tegra/include/ap20/arvi.h;h=6ce52e8e9a7213e33466d34a71cf3af2b6944b8a;

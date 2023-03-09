Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830376B22AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCILVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjCILU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:20:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22F4EBDB7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:17:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g3so5554947eda.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678360656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqElNSLK0wewsToqJsBP19ANjkxYgKuUVXliuRxgjCE=;
        b=iZ0dKIvpAq9vA74kVxymwieQC6AVFU7mMIkDpDJ1b5GSOrNqcpNSNkxBIdZqGievbI
         jdC/tceKdwe2duCQk9UR4l9xnRaivQpOBm2tP8NVmbhc2F5ieWMv3ULagm4yHR/l+enO
         CwUooVK4hsUp0m385zFv4L+BgwND9RuxumcdLGSRZV1kA4znWvmkY5wZBJTIz3JLJpHt
         I8bL84LIdYZ1eimK31TrSVYsVznNhTKzt+x1mE6USntnja9d7fpreS/tB/etv4aWYGzN
         uZpnrU5SvmRpo9ARgG8bat9b5CkGKwyZm/xXaRWPManZkMaI/Y5cBOUyKwrZoxtKBk2b
         AoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678360656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqElNSLK0wewsToqJsBP19ANjkxYgKuUVXliuRxgjCE=;
        b=7vXCt+p5O2Zu/FnFqDj+RMTwXZbNg1QwZogusTAlmSRfAfaaUDeWkwf9EV+1tPbzaa
         pgVfH3hWdSPJ5Bp6+FjQExqdJbxMWF1haPXIAG6aKsnDsvQskiAsFfn8Bz3PvK9KVlby
         ZsWkoaBNn6pg9J7WGR7U4ZvhU79Ak91ZNYQ39G/85wzO8w0LmPVSkRARuB1edCVTsZm4
         kgQcugtE4YBO6P/onDO6TPUDW7ALHQHqWfR3JoEVAxKncpagsPBpYNqNeVfMlJ4XCQSv
         +XHmKIiRysrC/tohAxaiWB16pUy+TqXImRBeuI5oASfK0oAhCikJeZXaZ/MtWX8GWXZT
         QALA==
X-Gm-Message-State: AO0yUKXK0Eh6KoBoTrlcT+MZizydVYclu3ZJrA/KfjZFH3ClJ1jPlTkX
        bzYKVVr0qTe5dQEwHvOcc+/mlA==
X-Google-Smtp-Source: AK7set+31t3ZdIaoZ3N0ZBz+LMqRAGwzF5KdIhimJ/HPNZzYJHhzkxw8YpMF87yAEYxIDl1juL2VVQ==
X-Received: by 2002:a50:ed94:0:b0:4bc:7eb9:4b2c with SMTP id h20-20020a50ed94000000b004bc7eb94b2cmr20331395edr.35.1678360656454;
        Thu, 09 Mar 2023 03:17:36 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id qw15-20020a170906fcaf00b008d57e796dcbsm8661784ejb.25.2023.03.09.03.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 03:17:36 -0800 (PST)
Message-ID: <23cb7d3c-4cf8-8d9d-dbdb-4391384a5726@linaro.org>
Date:   Thu, 9 Mar 2023 12:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230309104133.537056-1-lucas.tanure@collabora.com>
 <2881f527-1673-3496-85a2-84a13f074248@linaro.org>
 <af2de8df-b20e-4bbc-9f00-90b50546c4fb@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <af2de8df-b20e-4bbc-9f00-90b50546c4fb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 12:04, Mark Brown wrote:
> On Thu, Mar 09, 2023 at 11:42:42AM +0100, Krzysztof Kozlowski wrote:
> 
>> You are now changing ABI and adding undocumented properties.
> 
> This is newly added code, changes are fine.

OK, for the ABI code, but not for the undocumented properties. Commit
does not explain that.

Best regards,
Krzysztof


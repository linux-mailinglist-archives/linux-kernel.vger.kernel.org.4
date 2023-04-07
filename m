Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5456DAB2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbjDGKAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:00:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1961A86A6;
        Fri,  7 Apr 2023 03:00:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g29so4033340lfj.4;
        Fri, 07 Apr 2023 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680861634;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9Uv4dBullqwaEvWpSMa741x7XB8RZ1FWzbpdovf4yI=;
        b=pdMRUv6nowvbax6f/6dhM8UbNt4LZ9EMpl0SnhFs692TIuzByIW6pdMWdUuy8wZsfl
         4S0QnVlUE4bFlbW1RXb8Twe6JW4SaUD2Bri6gvdwfBkIhLfL1IcTWX/ZfCE7HZlChjgy
         Of062T3yqn6N+k6kcyD5tqdfnFbQpM3XqZ6Al0ov2qStjpLMlUQSgGodRNyLgYCiwl5p
         o6Q5uBB65W3pKS/Hr6yn7o++rwNSJQr3Lep8r8FJGaxLWdZoyslOypBQlliUR/FhklXW
         nrgkpr13EmUshyRRtVzJz7LS2Ec132LvU/2fXlehjgsYieaanCT8Qcf4Z64kI+JnlbNP
         l2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680861634;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9Uv4dBullqwaEvWpSMa741x7XB8RZ1FWzbpdovf4yI=;
        b=QDXxumFfiSQNAFnjLRng444vdGdfX+/t6WjFapDaccITAUaw1T219wBUXPnWABR7bH
         /HEu2mOpCrLgZIx8DH81pkE9pjxa/0VyE2Dt/a4frN/uWW87Z4rl0W0RvGunVp2gl/+e
         OYnlK9dnK92BP/Yv/VPTTYHD1xMLybqjscNqei8dKyF0mse1Tyac8vSaWVUsgdnNGyUx
         9S5Po2F85ZeHy68xrnb4bjtVtMPODoUymHBVEbmcnWdVQClUk3ZA5JLLGPdibRlXQybR
         lsNNnvvEro4VlxfS4saa7ksznh9zHB0bFqT8ieX8GAqz7Sffvfmh3xZCJTItcRVQ2571
         PyLQ==
X-Gm-Message-State: AAQBX9e8IhpvvylugipPrZTxK0Cmh4TXcxuda6qIIafsaRMBSgnjVmPG
        doVT6O0DBCq03mFuH5N2JLC049dqdDQ=
X-Google-Smtp-Source: AKy350b0KhClS9yLNLFOtzH8aMqtUdI47E+vaOk918E/fzp7OoFi6BercWVHoUaKx+XLT/Yhs8KDjw==
X-Received: by 2002:ac2:4a81:0:b0:4eb:336c:f10 with SMTP id l1-20020ac24a81000000b004eb336c0f10mr536517lfp.57.1680861634047;
        Fri, 07 Apr 2023 03:00:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q7-20020ac24a67000000b004eb3b752e10sm622858lfp.133.2023.04.07.03.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 03:00:33 -0700 (PDT)
Message-ID: <4fed5a73-74f1-4101-bbdb-b319f6435060@gmail.com>
Date:   Fri, 7 Apr 2023 13:00:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: ROHM BD2606MVV LED driver
Content-Language: en-US, en-GB
To:     Andreas Kemnade <andreas@kemnade.info>, pavel@ucw.cz,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230407050803.170773-1-andreas@kemnade.info>
 <20230407050803.170773-2-andreas@kemnade.info>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230407050803.170773-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/23 08:08, Andreas Kemnade wrote:
> Document ROHM BD2606MVV LED driver devicetree bindings.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

FWIW:
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


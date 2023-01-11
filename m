Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948FE66633C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjAKTFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjAKTFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:05:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC4ADF3D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:04:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9so17758231pll.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlzAnfauG/SrWpxzD/HFqmo0bekDwT+PiGFDCinqA6o=;
        b=07Nh4WTyDbwyfZzqhJ1UkQq0uAGvOjeK8lUiAK9rY289VOkv2sr8xYob6lNWPt8PuU
         ZPtIjprgFW1QCoxkSp0QLCobk/RY7yTOZPDzL3IkNEJ6wmXfMj7E3z5nFtVP46JyyEtY
         nLJ1On0cPoobJox9yphhx+0qNHP0q6mnV0Z3kuc2yFj0AKJpFVpu8mET3I7GVGG7Hvc5
         E1b1uJ25DO5jWpmgVO2ve4txrl65ZVgDjjTWsaBytLKXz9sv2ikLVsAPHzFsq01vaaCA
         RRYHvr5pZoZ5cV5nkNYoz0iycxNFaqFueUdoleRXzah1OBUHRcwguOUcA3gagrmYWnNe
         ZyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlzAnfauG/SrWpxzD/HFqmo0bekDwT+PiGFDCinqA6o=;
        b=WzjOz1L9VoTFlDPFXcbECq4PZrEooUbNeu1OaX91EDdrpMhuFGvuUnSU6BpEBVpT/2
         7Bryi2yfOklot+U27ErzSiVzHHdOGpLlhrSqxMT7EV/SbeC9LbQNPlH7DaHPsTAd89ur
         dPtQAn3jHU31CpMjnxoDdMb4NbVMItSrJpt92BNC3t2Cs4P960O6F6BE7BhNVgSr7otz
         LvfyUZyfgJ4ly1CTqSRsLINsLEDrul/KzAdv15qN90coVwVPdyPSMFqPMwvz4Dbjmkuk
         SMKdbF2wTqsHu/PcOc3wpvNb+PjXOxCc0w/kuBhRKg/4MrbT+hukY5ja6OicoiHztp3Y
         tFDA==
X-Gm-Message-State: AFqh2kqanwhFBChS/W+Vm2uBc1vaAURvHdtdiWXDwtS/c7UazawDksXd
        jKELlDqR8MK3zNHARc4Xgr0O8A==
X-Google-Smtp-Source: AMrXdXtzU+Q4Jj1NUJ0JrAuhndnIFmQRonwPtkOc39sQrciDCIM0yuPytaaqKIZACwMwK3j+qLLeKg==
X-Received: by 2002:a17:902:6acb:b0:191:40a9:60f6 with SMTP id i11-20020a1709026acb00b0019140a960f6mr16988537plt.0.1673463897989;
        Wed, 11 Jan 2023 11:04:57 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00189f2fdc178sm10529771plg.177.2023.01.11.11.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 11:04:57 -0800 (PST)
Message-ID: <ca08f6b8-a491-3a7e-f576-833acdf2135b@kernel.dk>
Date:   Wed, 11 Jan 2023 12:04:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V4 0/6] genirq/affinity: Abstract APIs from managed irq
 affinity spread
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
References: <20221227022905.352674-1-ming.lei@redhat.com>
 <Y74cXN4SP7FNtSl3@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y74cXN4SP7FNtSl3@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 7:18 PM, Ming Lei wrote:
> Hello Thomas, Jens and guys,

I took a look and it looks good to me, no immediate issues spotted.

-- 
Jens Axboe



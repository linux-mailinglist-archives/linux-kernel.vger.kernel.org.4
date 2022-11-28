Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3B363AB0D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiK1OcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiK1OcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:32:04 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AAB1F2F1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:32:03 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z17so5833425pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYzQA5+XofzkuI/jHdZUL6p8mJBbUYeRoj7O8Rf5OpI=;
        b=SW4xPqZEK4MUHUqPivuzG4pYf1aILgJDS/FfdSMbxx8hh+aidc5OMRnzM2GlgujG01
         dqDKMsPmdg06eDdTWDlTS+viqebr+pGplFJ6HJFgRPV2TQUVfWUr8EWyDLuHVwN8gS1r
         y6ESoff3yDBcoCMGUBK7GFbjoyqiyOg2dUQ5HHQEJnNPn9JHOzImnLywRUtNgGRrDWOG
         ZJc+qdeH+eQFlwSWVkHM+cwnOQErS33YBUL2LXrCbXA1Mp1gu/+SDel3dFBKzUqCEZnZ
         juV+JAPSToX5YcUNaIFkPVWGSbBqBrn/F6RkecRfCUY/PZrrBHY5FFwuItPyq2ZlSHdF
         WvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYzQA5+XofzkuI/jHdZUL6p8mJBbUYeRoj7O8Rf5OpI=;
        b=HZ7YOw0k7ijt+T3Elc2bhG82sderdANk6NSI4izm4eOOk/jLp3gGg3ibajRXr0GQSM
         m/WZu/E98oioo+7he0XwZ4odG5tV/z7PdMyr7WLuxHJ6g123YJ7Bcqoroy8ofVdn/sdj
         R9yOPpUEmpxzX0rUW9x1R/esyPvYOZ5wCuf8xj8mFhpZ2LJN+av+7M6GZUzK27VHvZ4R
         nu35jTVAujgk065QDtufx16nfEJLRcTEWwK2hONkPu4zGsJ6jpGNhrIZdq2BbJ5b5fwV
         Qh4sdXJZ9GlAAk05DcNPjz+e46JUOw+qCmGkw6wnrDmkBYz/dsYvAKJzp5naN02MP7Tq
         E1qw==
X-Gm-Message-State: ANoB5pl0Q8T22NDP9MJZUkD+GCh3oJrpGP7I4LwP2tYMpwIo2qml4oGB
        M8EE+4rMQl209AroPGEuH8cNBw==
X-Google-Smtp-Source: AA0mqf6e1tNCWXVdCniu5KAWoFanIymr34Pr667CIm+FDXDRMjvGr0iio1kf0DVBIwCtvuQd0RLTRg==
X-Received: by 2002:a63:b54:0:b0:434:911a:301 with SMTP id a20-20020a630b54000000b00434911a0301mr29021976pgl.50.1669645922460;
        Mon, 28 Nov 2022 06:32:02 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b10-20020a62a10a000000b005742ee3bf71sm8059568pff.20.2022.11.28.06.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:32:02 -0800 (PST)
Message-ID: <423e090a-ac77-ad7e-dfb9-dcbd189e5141@kernel.dk>
Date:   Mon, 28 Nov 2022 07:32:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-2-paolo.valente@linaro.org>
 <14cea0aa-2f0b-117a-4568-c80ca0513eec@opensource.wdc.com>
 <88084DDA-A705-4CFA-887E-021FC5DD89E9@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <88084DDA-A705-4CFA-887E-021FC5DD89E9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/22 9:28?AM, Paolo Valente wrote:

[snip walls of quoted, useless text[

Guys, can you please both start properly quoting emails? Leave the bit
in place you are responding too, cut the rest. It's almost impossible to
find the signal in all of that noise.

This isn't an isolated incident, which is why I'm bringing it up. The
context is there in previous emails should anyone need it. Not cutting
any of the text when replying is just lazy and puts the onus on the
reader on digging through the haystack to find the needle.

-- 
Jens Axboe

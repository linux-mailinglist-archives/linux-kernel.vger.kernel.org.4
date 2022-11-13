Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20FF626EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 10:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiKMJD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 04:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMJD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 04:03:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2845CB94;
        Sun, 13 Nov 2022 01:03:25 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5so5361938wmo.1;
        Sun, 13 Nov 2022 01:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JmZWt1AH7GYDweTdvgfYoYFrtudsx4xhvSn+ufWy0s=;
        b=pUdssdRRWJxSaTkqyiTWQMkicCNmcnJ1LnclsapoufQpo6ipfx2jLZ5YrfkFDXv0Ro
         PICTzluptvlqKWWvWbpxEF9vYAqDbl99pAxqTEWCjSJ21EsYWCGk9g1AX0JM4y9vttC9
         oJfB6MWrwSmnWAIlzbNGQukqdlfQCcr1lRkCgUX58xtAbJQBhA5qhWcsbd63fhHYKE7S
         CxRB4Bi2u6Pg9Zy9vS8Xi5fKo+b9iUw/KkzFHUlZcBlPzL7YlQsFh5QkFhAPZkW3bxqp
         SnLprhDytLjUo5wt9fWm0eD0CdctyHaWdSMacxnj7JejmSgz/+T8bLywTuzlshSpwMTl
         aFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JmZWt1AH7GYDweTdvgfYoYFrtudsx4xhvSn+ufWy0s=;
        b=FXoYXioW26xW856BeGQxoJJyvbOK7R/F8f20wdmBwrdFgHGG+cgVeWeHXgjlu+eGpD
         yl1vrO3okJF6TtoYljcYg79PorperUeeDmXlUbMe3AWDjmeToTCKA+Dft//FPiTNHfT3
         GF2j5LWNW56giZjDp2WIUgy0r3s6U69LgNPR7hGIUPzq6M4NlelBVIIwcTB2cyOuiRPn
         wKOuruKat2S1Bx1NBWgbsvX74CFprWMqGT8v/fUC2R6JyOogVluSXETw1rM8dlATSoR/
         iS6aEabgZR/a0pRv7jy3hBGw2BVYx4yJZPPD5a+jDpP3lw7qwYnNK0z0pklAQ0jzfDGs
         YQrw==
X-Gm-Message-State: ANoB5plG2obja3LRiNzg0vfYKxBCpNVkW5Dj/+RNtmERyr7p7hHlR+0M
        DXQ5Zfx/qnm4VIpPx5cApqI=
X-Google-Smtp-Source: AA0mqf51QXuND4ZAW0A+Z1cqQ37bL/NgbAWpL43bG8eUUB5IePUHJ4Xg5nQK0/k9/eMn+gyIWHN7fQ==
X-Received: by 2002:a05:600c:43d6:b0:3cf:a18d:39b1 with SMTP id f22-20020a05600c43d600b003cfa18d39b1mr5158032wmn.149.1668330203605;
        Sun, 13 Nov 2022 01:03:23 -0800 (PST)
Received: from [89.138.235.186] (89-138-235-186.bb.netvision.net.il. [89.138.235.186])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003b497138093sm8481070wmr.47.2022.11.13.01.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 01:03:23 -0800 (PST)
Message-ID: <c9a03f08-8117-cd24-b4e3-9e097e3069f2@gmail.com>
Date:   Sun, 13 Nov 2022 11:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] char: xillybus: Prevent use-after-free due to race
 condition
Content-Language: en-US
To:     Hyunwoo Kim <imv4bel@gmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu
References: <20221030094209.65916-1-eli.billauer@gmail.com>
 <20221113080558.GA5854@ubuntu>
 <2a8f59ac-9d49-ffa3-b035-809f2fac38ec@gmail.com>
 <20221113084740.GA6458@ubuntu>
From:   Eli Billauer <eli.billauer@gmail.com>
In-Reply-To: <20221113084740.GA6458@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2022 10:47, Hyunwoo Kim wrote:
> And, even if the mutex_unlock(&unit_mutex); of xillybus_find_inode()
> is finally moved, xdev may be released before kref_get() is executed
> if xillyusb_disconnect() ends just before the function returns.
> (Of course, this is an extremely rare case.)
> 
> So, in xillyusb_open() we need to move kref_get() above xillybus_find_inode().

First of all, that's impossible. kref_get() is called on a member of a 
specific @xdev's struct, and it's xillybus_find_inode()'s job to find 
it. So before the call to xillybus_find_inode(), we don't know which 
@xdev it is. That's the tricky part of all this.

The solution of this submitted patch was a lock that briefly prevents 
the kref_put() of all @xdevs. The way it works is that if an @xdev is 
found by xillybus_find_inode(), it necessarily means that 
xillyusb_disconnect()'s call to xillybus_cleanup_chrdev() hasn't 
returned (yet). Therefore, holding @kref_mutex guarantees that the 
kref_put() call, which is later on, isn't reached for the @xdev that has 
been found.

If you've found a flaw in this mechanism, please be more specific about it.

Regards,
   Eli

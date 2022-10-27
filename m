Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5F760F1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiJ0IGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiJ0IGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:06:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248C4ABD72;
        Thu, 27 Oct 2022 01:06:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y69so1381551ede.5;
        Thu, 27 Oct 2022 01:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ZnInTEdE6m53x3YlPmddOdHI+B78CP4lWnvW8zAy/0=;
        b=ijWZqBV+oMnTpDEG9zR9caw+iwlaX7CYJw2Embia1jt1NznC/HIaMuLgihBh63YR8P
         FduJhc5Du/rWyhH+BEO76Q0gLyyDvi1UMpTRrnc35G7zBKq7Ld+Ub0T3CTb9B2n7fiJs
         8cmBHpZSHKGgeD86hRzLZIT1Io1Nl7i1AVRR5zAmfnNz8JNQo1lAKiYFuw7bUJv+7BuI
         ynuwL9UP2+apZ+yumVbT7VHZIV+UIFwB4kgJ/xAR59IRrxhX3vLoG99cuGcA8dD949ZO
         xZVQE6n4Wn8yLon3vDh6CkrhbO7QldJN2Uu2dBHxM95NhI7M5pYv4asW0bZhNxXgl1Da
         c92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZnInTEdE6m53x3YlPmddOdHI+B78CP4lWnvW8zAy/0=;
        b=G2VMBoPgX0FUcscM6IRzTGhqvrtOym7SH/rywvV9QvGcN3NudmpRjl9TeoOg/gPHbY
         WttHTpde60CYfG8ioO1UTDjUtAJ/JUXcKVDrh5O108ohGyoVqHZX/AQykwkhIPiafKKH
         cQ6H2mis04j2e0eiHunvZaLhn8w/5C1B8YEHyvuwKuvBauTFdNz8j3lmQHBW4aM27oDN
         OvCilbdB4H8F7XhS8g+VCpH+e3LHC0Wm80jFLsqyTNVehpa+Pb6unb99C3jv/Xhq/YZh
         le0RcnIDMD9VyWWiJK79TkHfm1DEmWefiRqe4gXHElliQNZekY+VYVCZTV8H4KWx6qUi
         Sriw==
X-Gm-Message-State: ACrzQf2MvwjnYZKguLEuj4sFZ9ZFXrBDHH2ITBOCk/Nxh36C1muKh/ut
        H+vWB3UtPN3c40u2bdP0VY+86blQNnpEug==
X-Google-Smtp-Source: AMsMyM4GNhYQ44BzzIvPmqQwZphjKeseK6QEYBIGacPvv2evfrqgADiS5B1uSs32fGLhIFLBWpMg/A==
X-Received: by 2002:a17:907:9611:b0:78d:bb06:90a3 with SMTP id gb17-20020a170907961100b0078dbb0690a3mr41222667ejc.233.1666857959802;
        Thu, 27 Oct 2022 01:05:59 -0700 (PDT)
Received: from [109.186.183.118] (109-186-183-118.bb.netvision.net.il. [109.186.183.118])
        by smtp.gmail.com with ESMTPSA id h3-20020a50ed83000000b00451319a43dasm570872edr.2.2022.10.27.01.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 01:05:59 -0700 (PDT)
Message-ID: <ba308dcf-ed07-e0c6-4992-9b609e0d7626@gmail.com>
Date:   Thu, 27 Oct 2022 11:05:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH] char: xillybus: Prevent use-after-free due to race
 condition
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        imv4bel@gmail.com
References: <2e5cbdfe-f6cd-d24f-9785-55176af6c975@gmail.com>
 <Y1lL+dVsJo2zu3Gy@rowland.harvard.edu>
Content-Language: en-US
In-Reply-To: <Y1lL+dVsJo2zu3Gy@rowland.harvard.edu>
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

Hello Alan,

On 26/10/2022 18:02, Alan Stern wrote:
> On Wed, Oct 26, 2022 at 11:52:40AM +0300, Eli Billauer wrote:
>> To fix this, xillybus_find_inode() supplies the pointer to the mutex that
>> it has locked (when returning success), so xillyusb_open() releases this
>> mutex only after obtaining the mutex that is specific to a device file.
>> This ensures that xillyusb_disconnect() won't release anything that is in
>> use.
> 
> The standard way of handling this problem is different from this.  The
> driver defines a private mutex, and it ensures that any routine calling
> *_find_inode() holds the mutex.  It also ensures that the mutex is held
> while a new device is being registered and while a device is being
> removed.

Thanks, I'm going to follow that advice in my v2 patch.

> 
> Even that won't fix all the synchronization problems.  A process can
> open a device, and then after the device has been removed the process
> can still try to access the device.  The driver needs to ensure that
> such accesses are not allowed.

Indeed. For that purpose, the relevant struct has a kref_counter, and an 
error flag that indicates a removal among others, along with mutexes. 
The problem is the time gap from the moment that the struct has been 
found by xillybus_find_inode() until it has been secured with the kref.

A new mutex is going to solve that.

Regards,
   Eli

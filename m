Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874EF609878
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJXDId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJXDIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:08:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E0074BB6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 20:08:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 4so1516571pli.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 20:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlsZmEBE21p9J1jMFwhL5ri5TBwNvQhqBK5ytJSYJNk=;
        b=axB0IjFEDVR6dbNTgYOFuzAyK/SNlsxQEu6r8aXiVSPhG7mHWUm9Gl18SqT83cmBgs
         oGTd1DGHMUG2SZscDAOLWD98jyKfPI3w0jK35w0XABYCs7+6LMKEeCMFDQUPYfGptJ8S
         94UTc+O/r97wmrrzbyOljP+Tpt7XpIgjveO16L5sU9m/Bm3j6lXvMJ7dX4R+wCyg9xuC
         QCOJ9Tip/yCON7pJo9l7oCBLZCMmTZyjewH8e1scav4avMCZlWEEk8zt4MaIhmcAyadL
         OQmSp62FRDDNLh7Re+NQ4A13BJN094L9V7hESFhDfmqF3Xj2fEGGoGFHfbqramJsCZJf
         XQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlsZmEBE21p9J1jMFwhL5ri5TBwNvQhqBK5ytJSYJNk=;
        b=K+ccXHlwEi8V8FFiLK8bY7wESXLGISCvvYo8zdNcN3kodw/d1h2j/N4DPTUfuPu0/d
         p8WMNwtH8TIHplPVLVs+zK375E7VETYtyYQfcLu1dyrogvw7eFrWVMTnyt/lPVzUVE8C
         IKFKhFpqnUBf8aX2THDt1GinooGesphSDdmdMr+/wkdKKQ/h1lbCOlgnxDXFggJ8W202
         anxt8O4Oqv1DTW2XLokjOYQIbTboQNFb8l2hc52/hTSLl0yIWrmlha7ej55EFvF5xpJ/
         MNxx02FUJO6Ino7uD+zRgMzxHHvo5h99ODYFAFi0Tzu2Nl84AR2ZgTdeafCj0r4bQs8W
         AO9w==
X-Gm-Message-State: ACrzQf0yplV/cDwuNza4xG5v7b64HGedQreLknusUuWaD6TrOtU78hLS
        smLCQfX1Pqe1pgYsvLv8plne5Z6BeBpjUw==
X-Google-Smtp-Source: AMsMyM5cfElJsXwV17L8hG7UuzpLA7oOodxswudFsdwqyxQdh7SWr46WyfoAtbliaewFPhzl02V3fw==
X-Received: by 2002:a17:902:e94f:b0:17f:6df3:1a99 with SMTP id b15-20020a170902e94f00b0017f6df31a99mr31495772pll.20.1666580884016;
        Sun, 23 Oct 2022 20:08:04 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b00172e19c2fa9sm18771163plg.9.2022.10.23.20.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 20:08:03 -0700 (PDT)
Message-ID: <4863c6d7-ffdd-1304-981b-9b0644a87f4e@gmail.com>
Date:   Mon, 24 Oct 2022 10:08:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] staging: wlan-ng: remove commented debug printk
 messages
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y1L0FiKvrM9jjZG9@debian-BULLSEYE-live-builder-AMD64>
 <Y1VDM2kWIi1I5dqI@debian.me> <Y1VL/wITM64U6qLi@kroah.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y1VL/wITM64U6qLi@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/22 21:13, Greg KH wrote:
>>> @@ -1007,7 +986,6 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
>>>  			wlandev->rx.cfack_cfpoll++;
>>>  			break;
>>>  		default:
>>> -			/* printk("unknown"); */
>>>  			wlandev->rx.data_unknown++;
>>>  			break;
>>>  		}
>>
>> Shouldn't these printks be guarded under CONFIG_DEBUG_KERNEL instead?
> 
> No, they should just be removed as was done here.
> 

What if in case of debugging without these printks?

-- 
An old man doll... just what I always wanted! - Clara


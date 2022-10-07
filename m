Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE915F7223
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiJGACg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJGACc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:02:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7289833;
        Thu,  6 Oct 2022 17:02:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g28so3484046pfk.8;
        Thu, 06 Oct 2022 17:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYg/RvcgaNxKeP5eY8q8jtJ41j5gX5Rd2AG83SIvepA=;
        b=J+b0UU72ME0E807XJXhkWAmP6Gdk254tET0U/YVBTiUAAbSp2/mKZiSq3PzPbXbmsG
         dmAQBT7NWAUj5jL9I4cqJ3OyN3OYx2fzkLiGtDNmn6g442FshlDP+VPXufxmrw1NugCt
         vXoU6LtY6UFXGVNjfFHKaSDUE/+Ik+rv8BCuX/v4MMWS6VYPKMFyHWRzbbwZfGfqwoTj
         NZzk1jEeIP243N0gy31TMIWI/xyVPsnwcYHO/loptpNg/0nPIOel5bVOA0hwCxSU36w6
         E4PxinriXvL0lCOPqWAafEicdqm9XyGHoC1i65mEY6CjSB+kTkdv380oV4G6msbr7r4H
         Lslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYg/RvcgaNxKeP5eY8q8jtJ41j5gX5Rd2AG83SIvepA=;
        b=atTzaRKdNGIlfqS7zoP1gdlZcMAlBTDHl5XmP5k9e/PeTZDPQZPzyKyH3+c/TZ216u
         qZiHHvvkor4GbBCuCMM+0Pe9OAVlQdNJ91tf7NvQKqIK2rpin3beQ4GLbwz46eCU1sYm
         dpxLUz73yvUxCv7TkmKA3ORW4DjIG1ooOCFiBPJCcGGWyK72vLNHZm18LU39Gaize2MQ
         1CwxDfaLTRbFZid4vbJZi5bT70OBTAKR18cxoRS/OI2LtG0I3vJN8iE+KfSA1R67ZfzG
         Z1ZQUsW8YWj8Z5xXVVx4L0GNHqLqhDX95tzcr9nXuwmhrkfsjq/YfNm5jFPngphDZonX
         fv4A==
X-Gm-Message-State: ACrzQf0bTGwAcOfIq7pTITKyavlm7SzaQZadRndTwG8ImSvvLRUMJ55O
        253GfURo2NkG/inasRs8pWY0kHI66Fw=
X-Google-Smtp-Source: AMsMyM5yMg4VflvLyEw2sCxDHHod72rvlY8baYscBhKN/JDerdSIrLTQUn6Y/YYxchV1msAmHGe+bQ==
X-Received: by 2002:a63:1718:0:b0:447:9ff3:66c0 with SMTP id x24-20020a631718000000b004479ff366c0mr1975033pgl.521.1665100950604;
        Thu, 06 Oct 2022 17:02:30 -0700 (PDT)
Received: from [192.168.1.5] ([159.192.229.185])
        by smtp.googlemail.com with ESMTPSA id x16-20020aa79a50000000b0056283e2bdbdsm192834pfj.138.2022.10.06.17.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 17:02:30 -0700 (PDT)
Message-ID: <7000d9db-7a1f-01c2-b78d-2ad35ca4c148@gmail.com>
Date:   Fri, 7 Oct 2022 07:02:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] USB: serial: option: add support for docomo L-03F
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220914025541.1018233-1-chris.packham@alliedtelesis.co.nz>
 <20220914025541.1018233-3-chris.packham@alliedtelesis.co.nz>
 <621867a7-e513-c0c8-fb4f-2116d3aa8c7c@gmail.com>
 <a15dc62e-4a0d-805e-497a-010c9dcc4c9c@alliedtelesis.co.nz>
 <699018fe-dabc-21fc-1080-154555f210eb@alliedtelesis.co.nz>
Content-Language: en-US
From:   Lars Melin <larsm17@gmail.com>
In-Reply-To: <699018fe-dabc-21fc-1080-154555f210eb@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/2022 02:44, Chris Packham wrote:
> Hi Lars,


> Just following up on this. I've not been able to track down one of the
> actual modems and have had radio silence from my colleagues who did the
> original work.
> 
> Is the 1/2 patch of this series acceptable on it's own? (should I rebase
> and resubmit it).
> 


Patch 1/2 for NetIndex UX302NC USB modem has the same error as patch 2/2 
for the Docomo USB modem, both are LTE CAT3 devices and there is no mfgr 
providing only a serial ppp dial-up modem interface for high-speed 
devices like these, they always have a direct net interface.

I have dug up the driver installer from NetIndex web site, the interface 
usage is:

MI_00 NCXX UX302NC HS-USB Diagnostics
MI_01 NCXX UX302NC HS-USB Modem
MI_02 NCXX UX302NC HS-USB Application
MI_03 NCXX UX302NC Ethernet Adapter


and info in the driver files tells us that the chip mfgr is Qualcomm and 
the net interface is QMI so it must be blacklisted in the option driver.


thanks
Lars




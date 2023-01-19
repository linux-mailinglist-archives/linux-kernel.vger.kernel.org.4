Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084D1672EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjASCL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjASCLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:11:50 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156DF45BE4;
        Wed, 18 Jan 2023 18:11:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b17so955335pld.7;
        Wed, 18 Jan 2023 18:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tC+0mywWHqI+sqrHp46ZxP0mQaBVjvXQSSGY/6s8JQI=;
        b=MwKKJUvraeoEuIpY8/qTuM8EE6zymSdxg2cXYkSXtQtv+dVheaXG823DqtewR9Vi2E
         PbvwTseNXIWG0Qnv8XheYIGUNJLMj/TG8943/piHYSG8k4Kl0PNfusYhKqm+XY3tN7rT
         +ScYZKF6F6agPescxeX1cO8sLvyiwsZb4gS3RJVeQk8SPVB6uttqcOZK823VNjgNGBat
         cBXGcaa25L3yU7G1Hdb5/+E1gUR0UZl7qJgSvIOtcSzdURjU26SjKZeKZ+jiqiZjLXp1
         NRvjyeRd2PYg5QclbSYVczkSjuzJvi/NooF6auxx90uVPnpfUm39nc34xjdByQzfcBdn
         YVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tC+0mywWHqI+sqrHp46ZxP0mQaBVjvXQSSGY/6s8JQI=;
        b=AD9XV1FckODeesLL8wIHVEiLJZLNc09zA+aogGXQ31o7tZatBFSYS2Ey2YJJmLD8PX
         +OIld1g1lboqROQnzLNyK7L/5lHAUjF2FEVc5GcfxPYb/UzS2s/YLILpgaR1jayAU3U8
         S1VpMOik7nT2tkc2vqKOX3u+2XYzxQwPi2DrGOMmYi8QI06XWKAlbKYBtwp3ctveHmbU
         xlxqQtx3xT4py9C4RWJO4K3ofZEhj64T4aESrAPLdflNIabpX80ztF7triRjQ54mhZJO
         OumfiB/guQ6Br4gmuTLQCyVv87A48SpaEXDpkyzc5BnmyJt2SlMz+3nYz7h6/jPwZNSQ
         27+Q==
X-Gm-Message-State: AFqh2koX0yR3r46VE6U7H3vNwbZtqAq62BDp72KEo82kQST8W6+k8auo
        r9jFar4YrI0hUK3GInE9fbk=
X-Google-Smtp-Source: AMrXdXucTgx+jrYtDbLD/rzJHvHDUU3/BlPM0+iL/RjO/9Y603roCW1nW/5XiNSuuPrdN0RSXJE5UA==
X-Received: by 2002:a17:902:8c90:b0:191:2b76:612c with SMTP id t16-20020a1709028c9000b001912b76612cmr8077470plo.62.1674094309142;
        Wed, 18 Jan 2023 18:11:49 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-70.three.co.id. [180.214.232.70])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b00192f4fbdeb5sm10360889ple.102.2023.01.18.18.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 18:11:48 -0800 (PST)
Message-ID: <51023b0e-897a-4aac-8654-63c52de9eeb4@gmail.com>
Date:   Thu, 19 Jan 2023 09:11:45 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBtbS9oaWdobWVtOiBmaXggc3BlbGxp?=
 =?UTF-8?Q?ng_mistakeo?=
Content-Language: en-US
To:     =?UTF-8?B?dG9tb3Jyb3cgV2FuZyAo546L5b635piOKQ==?= 
        <wangdeming@inspur.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "fmdefrancesco@gmail.com" <fmdefrancesco@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <63c9e0aaf682ab012d27dced94d127b818-1-23gmail.com@g.corp-email.com>
 <Y8dXpe5CCo5Kl3Zg@debian.me> <67e5d78c78824176847cc5bb5798e12f@inspur.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <67e5d78c78824176847cc5bb5798e12f@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 09:55, tomorrow Wang (王德明) wrote:
> Hi,
> 
>  I find only one typo about higmem. And I have modified the subject.
> 

You send your patch as attachment, please send it inline instead
with git-send-email(1).

Also, please don't top-post; reply inline with appropriate context
instead.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


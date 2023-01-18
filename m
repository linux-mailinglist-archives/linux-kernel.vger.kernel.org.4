Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2716710E8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjARCMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARCMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:12:24 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311803F288
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:12:24 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 207so8974547pfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBGBElf5nKvK0nRRBEw8TKWhBT8goESvHLkQ0BFq8Nk=;
        b=qKtNqi+tU+H0pcTbX105SDwEnqDn7HBwcR1rs7l45WXRpsHaHeJ75VuA9cOp13JmRx
         OyY/7HedAj3VJfMGM/4stgANFeJPX0ejaX6SsulT64iOyuyZAm3QRgA7S9UnDF+zD9Ie
         TuH1SH4pmRC7eTv5tVZUNEK78bwEY7klN6OfubG5SdZZ+aKV9Sx3/mgWOjB19argJHsh
         vg3PtvLkAurutf23ivXrSXF+F3ZVro5X+3/ah1nA5SY81vdyELqW0ImvP6v8WIOisKbi
         IDD0r4pu/cXK+8MEQIc/oiOHISHNLk49WpxqH/Qldez5OBWhNW/h82A8npdINYOIX6Qp
         gaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBGBElf5nKvK0nRRBEw8TKWhBT8goESvHLkQ0BFq8Nk=;
        b=WvWkJ52N0Ga3neo/+uMp+xP6lrxUOMscGk8yffSjXjitZ4XLcaPr++2TKHjIx7wsgd
         SIeBTefrwQMw/r9WUCMteGKnfL4WMwGBRdTjlfAiobcGyBbeNOb0lh/gQnUBnV+ToCyX
         wrLHe9RTxLV0aNmQhGyAfqEZQIYdhe/wZ6p8kuGCAuUCEqcTboVeSPT/mMCBiKaBFwEv
         S3q6k3QVthtf8DlrCi9N0rr8XiaSXT9TfiYsQnqDYPWvip6U7EYKUL0UDKFgUZm4QsR9
         fQaCRUbmRTIuhsjXrLzGZSgBO3ehmYt5zvAzv8/6SXOmFI8Iu8sJme9Vkb2H9YDx+o5M
         umHA==
X-Gm-Message-State: AFqh2koRg2qzEc0gxm6qXje9HYhkOt3r8FWXgSmR+iyXMJ95RV8n3Vj3
        TP8wkvBNai7mpZhPIOeLcx0OlfAqgmUqCw==
X-Google-Smtp-Source: AMrXdXtci5mQoZ0DfaQvDbx6h2+A/0/VW5tuE2aMl5uJPsi0fjBQzEMp+jT0TwLG6BeJkk+DtRCaNw==
X-Received: by 2002:a62:4e8e:0:b0:580:fb8e:3044 with SMTP id c136-20020a624e8e000000b00580fb8e3044mr6457425pfb.22.1674007943610;
        Tue, 17 Jan 2023 18:12:23 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id r10-20020aa79eca000000b00588cb818ea8sm16554766pfq.163.2023.01.17.18.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 18:12:23 -0800 (PST)
Message-ID: <ae4a96b5-4ce5-2453-b790-efb5ccf0ab2f@gmail.com>
Date:   Wed, 18 Jan 2023 09:12:18 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] Fixed typo in comments
To:     Semen Zhydenko <semen.zhydenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230116222254.74479-1-semen.zhydenko@gmail.com>
 <Y8YUvsLVZZvGZo3T@debian.me>
 <CACbEQFHP90RYNEBGP5jvPNVYciuiUwA7G0Gp9_8KAKc4-hgUTA@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CACbEQFHP90RYNEBGP5jvPNVYciuiUwA7G0Gp9_8KAKc4-hgUTA@mail.gmail.com>
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

On 1/17/23 23:38, Semen Zhydenko wrote:
> Thank you for review, will try to update my patch/email accordingly 
> 

Please do not top-post, let alone sending HTML email (like this one),
as mailing lists (like LKML) don't like HTML emails for often being
used in spam. Reply inline with appropriate context and configure
your mailer to write and send plain-text email instead.

Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara


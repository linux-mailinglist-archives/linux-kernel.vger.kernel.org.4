Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2221A6A5404
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjB1IAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjB1H7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:59:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43962B638;
        Mon, 27 Feb 2023 23:59:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso4837395pjb.2;
        Mon, 27 Feb 2023 23:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677571170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXTYFo40FyvmsbZ+pLf8ZZB+7BCz0ihNHXxTIcIpDNs=;
        b=RVeSBRzbOa+EuQqmVJXUTPHOpSwhYuvUC/pM3VLqWIQBHBDw6fuRzLgmVhQS0ndwlJ
         MoDg85fddy+3aEjTGHErwr4n7JU11ZbgFi+WkHzecd+zRBNR11QuiiWAnQde06TWV+hp
         3W/N0ZAzMNPD1ulM+E8C6Kjj53QvTfwpST9PnMBAb9HC8zdx1e4PEgS7Be2lX+dnO2jj
         pUo540b0IISYEQO6JqEMpcmXrKDPhsY5zm3DYFs+99awZLUR7rV/59Tc8dHsXr43zE0t
         wI02jl9tyOh+/FcV3bPVsCGTwtiyvKH+yBG7iXROXsfNXUekN98XInqsBNehOP5FhdR2
         zSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677571170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXTYFo40FyvmsbZ+pLf8ZZB+7BCz0ihNHXxTIcIpDNs=;
        b=nk3O52QEvepqVOm3sg4ilNzDd5vDtJi4oasev8ybBYIlaFFnZs3gyALj10xEGk5dxL
         YVdU5strdqqNTvW3bXYEnv/4OEuiWoJFOYQgm2E+KHc5eU4lTswdp0GgJu3eAOlJiEpc
         YsblNT7aGL156cF0ei78WHV4fJFwHLB9PkV1HAacPNRJvuxXKpW33B48LHQnLUMYd9jd
         Gwa5vvrhMReDJNHtJhnB2izhkCoQSb+PFufzfP4dcy0HNpgYMXgabX9XKzaDUTleRjJa
         Zr2m9/OA66WTa5DZtamgPiPjogBGuCVqUmMPo7G5vFnS/ts6XSNTZQzGjKq1cPcc41f2
         f+4Q==
X-Gm-Message-State: AO0yUKU9Grbnga1kji2I0mDFGSQtLGM9LBk9aBJ0nnbmSTlQTYEm34Xw
        hV7+CYKSYlYSbqxNo/fpmfs=
X-Google-Smtp-Source: AK7set/eBaP+MaZDFG1k/pZohuSQ5/nA7B3iCLgoKqKaj9TNgHwIMwVMLk1B1qx7hRKNAhESTqGYzw==
X-Received: by 2002:a17:90a:3ec7:b0:234:106a:3490 with SMTP id k65-20020a17090a3ec700b00234106a3490mr2374093pjc.40.1677571170373;
        Mon, 27 Feb 2023 23:59:30 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id fz2-20020a17090b024200b00233aeec339fsm7487535pjb.1.2023.02.27.23.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 23:59:29 -0800 (PST)
Message-ID: <9f26074a-ee21-846a-46a3-072cc0630b4e@gmail.com>
Date:   Tue, 28 Feb 2023 14:59:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Documentation: gpu: add acceleration node section
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, ogabbay@kernel.org
Cc:     Dylan Le <self@dylanle.dev>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org
References: <7799513f0fb5aee27b64752c037980471be669c5.1677120686.git.self@dylanle.dev>
 <Y/bqtlbnWkKMIJI4@debian.me>
 <CAOCk7NrAKZ2G-VbQW3MJUZmkKkO1Ccrs2wo12kg6QHysH-d=Yg@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAOCk7NrAKZ2G-VbQW3MJUZmkKkO1Ccrs2wo12kg6QHysH-d=Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/23 23:43, Jeffrey Hugo wrote:
> I'm thinking the drm_file.h reference is broken.  I suspect it should
> reference Documentation/accel/index.rst
> 

I think so, but since the doc tree above only contains "Introduction"
doc, the reference should be that doc, right?

-- 
An old man doll... just what I always wanted! - Clara


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AEE7460BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjGCQc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCQc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:32:56 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CCEFD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BiYigt7zYTuTfpoKc6uqrwZviUtVf5LAgZDNhGxhXA4=; b=YXRILy88wcvchL4Qn3p6zh+sZ7
        D732sKKK0mLOMPbBeqfJNF9enbwuVY++PhYphitoHulx7i3OL0JqnG4AZ3Ried/ye3jfohr0+lQwd
        1Dh/Tu0U/PQX23ub+qNoWMseUX2DdkKAT7GaHLKYyl13KR/2H/1kvl29aZk9RhZFtWXKKE7N0EjH+
        cJxtqfo3JV1sZP2AyX19btqLOhDlvlSTfI828gy0REnWIQCvL4/lT7ySZBrEOq0LBRa7Ko7Q3c1ab
        8JPBv6S4WBZwQXuzzTnXQvABSc69samyzuxr03iZHqDxE8ZrMysVNnZjkih5RmywgqAeo7FYZ+ALy
        hL2YU7Tw==;
Received: from [187.74.70.209] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qGMTo-007hfu-14; Mon, 03 Jul 2023 18:32:48 +0200
Message-ID: <5bc889d4-bccc-9d6d-fe35-da3e9627eaa0@igalia.com>
Date:   Mon, 3 Jul 2023 13:32:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 6/6] drm/doc: Define KMS atomic state set
Content-Language: en-US
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
        Italo Nicola <italonicola@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com
References: <20230701020917.143394-1-andrealmeid@igalia.com>
 <20230701020917.143394-7-andrealmeid@igalia.com>
 <20230703113836.60869599@eldfell>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20230703113836.60869599@eldfell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Em 03/07/2023 05:38, Pekka Paalanen escreveu:
> On Fri, 30 Jun 2023 23:09:17 -0300
> André Almeida <andrealmeid@igalia.com> wrote:
> 
>> Specify how the atomic state is maintained between userspace and
>> kernel, plus the special case for async flips.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>

[...]

> 
> If you want to take these and need my Sob, that would be
> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> 
> 

Thank you very much! Your version is way better than mine, I'll use it 
in my next version.

> Thanks,
> pq

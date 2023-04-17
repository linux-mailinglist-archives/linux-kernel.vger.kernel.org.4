Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F466E41FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDQIEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDQIEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:04:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9831F196
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:04:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id gw13so13304256wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681718649; x=1684310649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxAVc0ncUnjPKeybMVjKd5qlxZDMp8oAMzg8SofTCCg=;
        b=CAKf/vDt8JEBGp0mnnx5TlC2WmrwGF+A9JBXRln52KHrtc9rD+bXz46fUMASfxJnTt
         rkz555Z+QrhLasN8SSjr9Ae5e7g99errmpTjhcYSInlAWWoGVnAr9x3d9HAXC5I17+Ji
         iixNE8eqUHvKXVDOknf/NJBq8SHchC6FVsoVcjcyxNZE140E1OpQ0TfTEkuq/H6zXudw
         jGpxBG6f9Z+DU7i/VQEh0XBVW5xdaCTmnQlu1hp8AgwPd1ABZtTubLZ130oy7TEQ968X
         5gMxT4hrbGMFvcB8D4yVw7/afVm0JrthXGU9FuiIOU653DoN/jKp7bENCPw9SVinghb8
         HHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718649; x=1684310649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxAVc0ncUnjPKeybMVjKd5qlxZDMp8oAMzg8SofTCCg=;
        b=dR1fxE/5DOx9kO2EZy9GTJ3l3VXnzEKO4whzHT4YJloock+OS1xsNDNHMIHfUACW4A
         p+nGUS+g5OLsW/um3wviNRPZoa7RyYEvMn56jKpKuI173cciFhJxfZ0JFv8SY0uudELn
         q/AKxLdiXZSQlSt8qwjgMNjq/ErHtcXj5CHF48JrzVkFWHntTOEqXHWtA8F3tkZszB7x
         uMTz4DNbKV2c5jTi2yF/HOUWHdS489ZfBgCFFxKQsCeOsRQtWR6fPTGX2fZsvVUSxpSW
         wnsJSC3U2uJe+HPx3CCdq0e4vxwua1ru1OSz4sAAi/cl93jfe1Q5W/NgM4mAlGQsw/em
         kS9A==
X-Gm-Message-State: AAQBX9e6eObz0BZsFurLImduSGFOwwmfsIN5IpY//aoP5ySC5vh3COjn
        Xp99rXuoXMbby/atEKtsXWE=
X-Google-Smtp-Source: AKy350bvdQ80DHlW//KAd3GP1I9vxuwmVkjGlB9HPTLmGejdMKeM55i79/l8QkDjq1D7/B3F+Bjadg==
X-Received: by 2002:a1c:7c15:0:b0:3f0:b095:15d9 with SMTP id x21-20020a1c7c15000000b003f0b09515d9mr7262274wmc.40.1681718648924;
        Mon, 17 Apr 2023 01:04:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bca49000000b003f172db455dsm3366558wml.32.2023.04.17.01.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:04:08 -0700 (PDT)
Date:   Mon, 17 Apr 2023 11:04:04 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Luke Koch <lu.ale.koch@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wlan-ng: replace rate macros
Message-ID: <f44f44e4-25c0-4489-96e9-8ca63fa294d7@kili.mountain>
References: <ZDqwZKZHyZZX4b2J@kernelhacking.kernelhacking.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDqwZKZHyZZX4b2J@kernelhacking.kernelhacking.example.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 04:10:44PM +0200, Luke Koch wrote:
> +	for (int i = 0; i < 8; i++) {
> +		if (count > i &&
> +		    DOT11_RATE5_ISBASIC_GET(item->supprates[i])) {
> +			req->basicrate[i] .data = item->supprates[i];
                                         ^
Could you remove these spaces before the .data and .status?  Otherwise
it looks good to me.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


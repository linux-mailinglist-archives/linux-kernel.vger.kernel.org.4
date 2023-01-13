Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB7A668F53
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjAMHjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjAMHjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:39:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED32642
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:39:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z4-20020a17090a170400b00226d331390cso23574022pjd.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nem0KGVeWs0u59oN+VKYDUtx5w3BXdJrIOfqnvfQKls=;
        b=ak2mIBtmvgLjfoPMJpoGvFi8qhD9y0nqnJ8JDCF3itBst44IJhPv8whUVxrA5BeEbN
         2mTELUcwuFXFX3H3ZeEf4wljJGbokkEEGkkQ/eNJ8LeuIAVnNl1becbZ4fmKEdttA8Dh
         ZKchQpHg8shcoQ1amIEEGbbom3oz0vMY83dX0knUDLVYbEsCBu9fiaxKYcA3V03O/OXW
         Bg5oqPlKkqJlnEbIrSfcyWNsqXigy49GALRWRaxADMU5w2ZlB1ErDzyLCkeDQNJ/DSI9
         sL6qnvcctsH6Efus2B+NB/3Q3Ry643m7IaNcyyt7iAY0D+Fr782GIJXHx25eEMHcBzFH
         QzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nem0KGVeWs0u59oN+VKYDUtx5w3BXdJrIOfqnvfQKls=;
        b=tlVmzOPMavvtNE+JmvmuTbFCf15HGQPkuLzuIh26+EIhoF448JT4V8Hrk2xfE0uTZi
         3cXrKY0VFwChUbttpG4PmTFKllj14fzX74o3KwdW8rCUBWad4PIFmM4GVatw1wc6ra53
         orvMd85aS30y7JzbaMY7h80vf3Vrr710P/ggQiJHLexbwnBbErF2jM4m1OJIJ4NRZqcX
         TUEemwUYNcl+EWYNpJ97lkcyXwvroZZoCoXhYVhpxcOw0qVXcnsQLVZuRyXkASmzVuyC
         Zv8qivkUezorT8GHEyYilUR0Xg6xC98twrd9HTigbidPDuIxw1N798i8HgFcRU7hoTL8
         3FXw==
X-Gm-Message-State: AFqh2krGqQGf7zRlIDaYQb6t8Teg9HFfx0PX+WZRiEkwX8CF7UlNg9Cy
        h931ZXAW8jJpOTgQXusST6Y=
X-Google-Smtp-Source: AMrXdXtK4onV1NMvixLT7yn/U/dySVbMGDiBAjiVN+dgrZw6ihHmwHUcpqaY1TB6iXu9+52fEo+2zg==
X-Received: by 2002:a17:902:d587:b0:194:457d:6dca with SMTP id k7-20020a170902d58700b00194457d6dcamr12306423plh.44.1673595555559;
        Thu, 12 Jan 2023 23:39:15 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b00186b8752a78sm13488176plf.80.2023.01.12.23.39.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jan 2023 23:39:15 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:44:27 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 2/2] erofs: remove linux/buffer_head.h dependency
Message-ID: <20230113154427.000053dd.zbestahu@gmail.com>
In-Reply-To: <20230113065226.68801-2-hsiangkao@linux.alibaba.com>
References: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
        <20230113065226.68801-2-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 14:52:26 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> EROFS actually never uses buffer heads, therefore just get rid of
> BH_xxx definitions and linux/buffer_head.h inclusive.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>


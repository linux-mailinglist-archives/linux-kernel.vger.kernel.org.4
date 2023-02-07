Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A01F68CC55
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBGBwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBGBwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:52:43 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AB02005D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:52:37 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id ay1so9738397pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gulD7/kEHZP9aV24EBXw4BTF6qeGzgE3oWiXaNuNyM=;
        b=NnftswKdW/GuNHmKgvrK/YjFAXvgrmAgKu4HhzDGFosWw1T1E5KnEEGUmNksLJZ6mC
         Mp6PFpGNBHNIK8n3k/nUG4spq2I9kRUVNz0EWn2ZAG+jzrS585ET/bhpJ7SZhQaIpcM0
         KtyPBKvZk1GAh5Ik3rFK1zNJHpoBpExhRtSAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gulD7/kEHZP9aV24EBXw4BTF6qeGzgE3oWiXaNuNyM=;
        b=wGvSWgh0XfE5iq9jXYndqi179h9dgqOzmdyMt+CKfv2NqhedizPj4QbDfqcDbEU5tP
         yHHE55grIu+p4UPeDWYOkmFjZqi7dT7oNPLUlgWGBTnDsbJi/lEQvIQgNH4z+OS1Va/O
         ODSwjquOCbv+fMVNJ6G/vjAPKiQ/geGhET8OIBANIoAdlpw1XZjQ2Phh9Ykr60HxCPOr
         fdYx78Rtj+Bja+KZB88H2SLXaAuAzfxSBUc32jSmiuoSln0CJzSBKnti1uISbBwyos7m
         LvCuGoO8kFU+x/kaxzJdPwl/L/na8x2ywkC1tvujb42CgiQKAOE6T+eR5rEUt3AS3afV
         dlqA==
X-Gm-Message-State: AO0yUKWbN5Qsx4q3NUgzfNw4Pw56n5Z+922i8+yaa8vizuP4zHX25NDY
        ZwyigNYLYroYHzkr/I4MB4rIAg==
X-Google-Smtp-Source: AK7set8H+dbd0lJWJrpQxSUZ22uAN3nmgTC75O9U7b3Or9fM6qgLl71NV1ZLUSb6i+Pgt8FcSG+KUQ==
X-Received: by 2002:a62:384f:0:b0:593:c41e:474 with SMTP id f76-20020a62384f000000b00593c41e0474mr1299789pfa.9.1675734757406;
        Mon, 06 Feb 2023 17:52:37 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id h11-20020a056a00230b00b0058837da69edsm7817189pfh.128.2023.02.06.17.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 17:52:36 -0800 (PST)
Date:   Tue, 7 Feb 2023 10:52:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ksmbd: Fix parameter name and comment mismatch
Message-ID: <Y+Gu4Fg00D//CGpo@google.com>
References: <20230206072029.32574-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206072029.32574-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/06 15:20), Jiapeng Chong wrote:
> 
> fs/ksmbd/vfs.c:965: warning: Function parameter or member 'attr_value' not described in 'ksmbd_vfs_setxattr'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3946
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

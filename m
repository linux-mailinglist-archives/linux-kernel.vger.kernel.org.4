Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2BB743F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjF3Pjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjF3Pjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:39:36 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C8930F7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:39:32 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3426f04daf8so2104815ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688139572; x=1690731572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GW4hZL9mt4ivrUPperLWHI1+1eLqsC5B64iKsS7Hy+Q=;
        b=zaYlwpyqR1r+ylRi1/dLp+c0bQERixaHgbimhfhmJNvExYP2eGOgu8XnPw9vM8Hpjs
         R/UcmdlbZLrh1XM0pnbfSojW6rollvwv0+PNPtVD8UEK5ob7zqGHxllt9cyX7ATSVFVF
         RXMBYj155B6MqGnnx1zSj/T5+9HhABeQco03tqlI0QEPXLVNyoLvMc/sOEDIIRLSFN7k
         I6WIAwX+qTU9JsijQBmlKOHfcbxMihndDF9oXu//eGUGLNhp+dwHH+8GlXY+Q+HHaI3z
         lc7mPJnjoLPyyjLVPHXIsq+ixQj9M3Ee0ouIuB15+t+PBxK0nJlW30ioMK8NB12pwllH
         RT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139572; x=1690731572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GW4hZL9mt4ivrUPperLWHI1+1eLqsC5B64iKsS7Hy+Q=;
        b=RZcj6PIchCZSSzF0rveFVZ4c4lxIGNm5MDg/sQpvk2+PGj12Fr8nZeosw9tgSxdhC9
         jVQq7qUQvGT3iDsI3D/2oWPyTP2JI6lwVVfOIC637u2BFtNj0+y1YVxSB7Jx1OTFQMLB
         siWvBmJZ3CHgoeoxpHoKgxmJaUqi5srv2M+gKO5uWHJsjL99dNNG6uBi+RgC48ikxG6W
         TPT95rPyxO72FJrjcC4aS1qAwgNOUCqW5w01wqRIH8P92opnKltQX3ul4w8M4XYpb8lG
         NVWMzdQFHtpN4rBBJTOuhXbgTXzO3giKrz5olQRrDhD0hs8DMrt1AH/a6NKrPDGkULek
         wXxw==
X-Gm-Message-State: ABy/qLYH3D3F42mngBNZ3dq9xDWENHkjP6V4O5ngd48cJNJ9z4zTG3gU
        RccAqDHetyrwaiQ0t6g533xtcA==
X-Google-Smtp-Source: APBJJlGx0U82VVFMbma5VnBcP6dGqi3j+tVO+N0aGevcZzzCTGDk10Waj4U7AeCx8trU4YD9mdXzsQ==
X-Received: by 2002:a05:6e02:2195:b0:345:ad39:ff3 with SMTP id j21-20020a056e02219500b00345ad390ff3mr3977556ila.3.1688139571782;
        Fri, 30 Jun 2023 08:39:31 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c18-20020a92c8d2000000b00345e4c4f53asm633703ilq.40.2023.06.30.08.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 08:39:31 -0700 (PDT)
Message-ID: <36eda01e-502e-b93d-9098-77ed5a16f33c@kernel.dk>
Date:   Fri, 30 Jun 2023 09:39:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 03/11] vfs: Use init_kiocb() to initialise new IOCBs
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
References: <20230630152524.661208-1-dhowells@redhat.com>
 <20230630152524.661208-4-dhowells@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230630152524.661208-4-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/23 9:25?AM, David Howells wrote:
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 1bce2208b65c..1cade1567162 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -655,12 +655,13 @@ static bool need_complete_io(struct io_kiocb *req)
>  		S_ISBLK(file_inode(req->file)->i_mode);
>  }
>  
> -static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
> +static int io_rw_init_file(struct io_kiocb *req, unsigned int io_direction)
>  {
>  	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
>  	struct kiocb *kiocb = &rw->kiocb;
>  	struct io_ring_ctx *ctx = req->ctx;
>  	struct file *file = req->file;
> +	fmode_t mode = (io_direction == WRITE) ? FMODE_WRITE : FMODE_READ;
>  	int ret;
>  
>  	if (unlikely(!file || !(file->f_mode & mode)))

Not ideal to add a branch here, probably better to just pass in both?

> @@ -870,7 +871,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  		iov_iter_restore(&s->iter, &s->iter_state);
>  		iovec = NULL;
>  	}
> -	ret = io_rw_init_file(req, FMODE_WRITE);
> +	ret = io_rw_init_file(req, WRITE);
>  	if (unlikely(ret)) {
>  		kfree(iovec);
>  		return ret;
> @@ -914,7 +915,6 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  		__sb_writers_release(file_inode(req->file)->i_sb,
>  					SB_FREEZE_WRITE);
>  	}
> -	kiocb->ki_flags |= IOCB_WRITE;
>  
>  	if (likely(req->file->f_op->write_iter))
>  		ret2 = call_write_iter(req->file, kiocb, &s->iter);
> 

One concern here is that we're using IOCB_WRITE here to tell if
sb_start_write() has been done or not, and hence whether
kiocb_end_write() needs to be called. You know set it earlier, which
means if we get a failure if we need to setup async data, then we know
have IOCB_WRITE set at that point even though we did not call
sb_start_write().

-- 
Jens Axboe


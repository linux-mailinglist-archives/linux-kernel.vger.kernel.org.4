Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B2A658B59
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiL2J7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiL2J5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:57:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F98A13E0B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:57:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso11101770wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbwl4qUPGRAlJXKlemR7F5hUymgNY+Rqyr3JN4InMPI=;
        b=bgeSrfqZLnb+LKnbAay8ONwFAens+hd+UfOQR1Sd7f1DOgjG5jCK21So0RDgTDPWJy
         Smuov+DJQd+e31TYKZCTUyCp4tNp9P+TBKHf1kHYSnqeTKOF1etaVsiMoEuS689DGXlg
         Pp087ghit5bz8fRhRc/goMUax2nyjBbZJi9NZmbD2QjBFLu2bGlE93JOueyK51LHssCo
         XfGyuz2LT4I/w6SDsbYhCSidEDw4oGHrkbFzD2A7hPZPWMfG4jJd8H8kUPtYOjyOhbxb
         fQZ8xvVxfp7sFzeGPk5xm+UDjSrQSiNP7QlL3ciU9E5MXDCYZRV+9IDOjouPCWmVjF5x
         yxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbwl4qUPGRAlJXKlemR7F5hUymgNY+Rqyr3JN4InMPI=;
        b=lIzyoHVPPbg3janlAFLWPFSOnCbxZ+VDjvHiYxThsdGbpcWa60qwfAb5emJx33XObi
         u+0cZZspTixopJdPMehVLUKORD7eS/+8W71QSmhPVLzXDmw8QiSbfzF5Zn+d5jSbjKe5
         Jo4fzCVrHGQvVScRduiYOXm+Cqvia7bixZ8vYt9BUNcPwajmf1bIQ6tlbZt+t09TXm5y
         RNrdW3Xds6lpSjdmljOjQ98mhOLFEFrYzu1trjSkU62CisSHuKM1+kwO7lFr7fJZXCZI
         LzPd5XSEUDPhfHMHFdonwSP/rrgtLCq/6ohxBpr7+ARovs09+R52/DW0RYp8iEE9GsUC
         Wl1A==
X-Gm-Message-State: AFqh2krNxtvRRXYfuKlh6lKrC4j4w5dHjrdXM20KIH+Ns3mTmfHZ10PF
        yyKy/9w8gZ4lISG60ZO45D8=
X-Google-Smtp-Source: AMrXdXv571mtW6o1ZZg08VCmlfl6qxlVXOPi+4bXkKaKnWTZcycK0kaqf2s2O60b86m50CBZyJ9jEw==
X-Received: by 2002:a05:600c:3d8a:b0:3d3:4406:8a37 with SMTP id bi10-20020a05600c3d8a00b003d344068a37mr19611689wmb.41.1672307857119;
        Thu, 29 Dec 2022 01:57:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c4e5000b003c21ba7d7d6sm24386690wmq.44.2022.12.29.01.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:57:36 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:57:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     yang.yang29@zte.com.cn
Cc:     larry.finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, martin@kaiser.cx, abdun.nihaal@gmail.com,
        straube.linux@gmail.com, sandsch@northvilleschools.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] staging: r8188eu: use strscpy() to instead of
 strncpy()
Message-ID: <Y61kjbim7IDSLSyd@kadam>
References: <202212261905476729002@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212261905476729002@zte.com.cn>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 07:05:47PM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---

Looks good.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD33C6EBB11
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 21:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDVT4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 15:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjDVT4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 15:56:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9462E19A6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 12:56:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f196e8e2c6so11850915e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682193403; x=1684785403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9yZH5jobw+2NxtflHbFeViB++WpgYUG8lLecB6Yof4=;
        b=CtthS9YsA6btqa4JO6vI8qG6Ei18swg2oPFg8KSHXvYFTzsNah2B3GZZ2DkXLIK3Bu
         WM0pmmAqy8lmu8V5P5lBn6SpKmEQLfSQRnN9RvwhNc6BvTCdoCQ0A8lMUYzZCukwctyR
         aHCIqkRnqpEv6uttQW+6QMeoM+SujZq10TVVXX8rdWR6DXNqDEHeemDTMcLHjoTM9FqD
         doVI7jomezoHjx23hxLkDztftgUtxd1JXMvb2eIKQW5Ntoilq1SiNUJUzrOmd9GQkQoP
         hzz2hmyx516OXcG72SALiwE7+ltPW0o7cRxRdqn5nMsGaCPULJuP4JTnjbysaF57fbUW
         1L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682193403; x=1684785403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9yZH5jobw+2NxtflHbFeViB++WpgYUG8lLecB6Yof4=;
        b=StesO1l4gAnEQEp3hFEMJtNHfqYkLTYkbdicA9vDU3Dn4gPa5oyxj0YigpWhIFKExq
         ONHeDZsfSjlQDwxlccZjNIpNze2MJKIGybvoxCCw89hu1Qzvg8E+KHk9ueK/+L5HNv91
         UFSojeUNKDfonhv5rRv8WJGHwwVfKaxRbF+Ww066Z8Np0/o1/jBxIxYalQJ8al5qapbJ
         LsSYtmuEnsojC8mLTbr/QNOzASeF+5kG5y61srRlDMstnsvNcQNNeMlyl5p1wedCtzgk
         kfp9haUYx97AOxwh7xMV2+TFT5Ofj+TjL4VX+IVR87vHnnWWbRiSTQdyeSeFmc2mArVY
         ecSg==
X-Gm-Message-State: AAQBX9d8155irkGUhRBeYGAkmw24egsgoufj30uWSZ1JFZNnXBWt28pS
        6QrAmqToIm0tnPpSP4jI7VqXoA==
X-Google-Smtp-Source: AKy350aU1g4P2e/Je3n5HyLAU9lTZT6CKyVdRbmopfPN/a5RVwo2XdTRo1sK9qdXYS1MlABzSAFFUA==
X-Received: by 2002:adf:e2c8:0:b0:2ef:bc0b:e70 with SMTP id d8-20020adfe2c8000000b002efbc0b0e70mr7197653wrj.54.1682193403110;
        Sat, 22 Apr 2023 12:56:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i3-20020adff303000000b002f4cf72fce6sm7206104wro.46.2023.04.22.12.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 12:56:42 -0700 (PDT)
Date:   Sat, 22 Apr 2023 22:56:39 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Vicki Pfau <vi@endrift.com>,
        kernel-janitors@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Nate Yocom <nate@yocom.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        John Butler <radon86dev@gmail.com>,
        Matthias Benkmann <matthias.benkmann@gmail.com>,
        Christopher Crockett <chaorace@gmail.com>,
        Santosh De Massari <s.demassari@gmail.com>,
        hust-os-kernel-patches@googlegroups.com,
        syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - fix GPF in xpad_probe
Message-ID: <c12873b2-d2e5-4fbc-987f-fa96cbe926da@kili.mountain>
References: <20230414125603.686123-1-dzm91@hust.edu.cn>
 <c3e0823b-2b03-4dab-b7cb-a8bc5151f0b1@kili.mountain>
 <011c00e7-c351-4331-8be4-1c184d5773e1@kili.mountain>
 <3ccc85bd-0541-4ffb-a207-dfc533a2c0aa@kili.mountain>
 <d49bb5a2-ed78-4b16-b7ea-b9c7748ca0e4@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d49bb5a2-ed78-4b16-b7ea-b9c7748ca0e4@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 10:48:32PM +0300, Dan Carpenter wrote:
> The warnings from this are quite promising.

Well...  The results are over 90% false positives.  But there are still
probably 15 bugs in there.  The printk warning trick would probably
work.

regards,
dan carpenter


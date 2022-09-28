Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2CC5ED232
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiI1Ast (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiI1Asq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:48:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC81CFBB4;
        Tue, 27 Sep 2022 17:48:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c24so10524288plo.3;
        Tue, 27 Sep 2022 17:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qa8OBz62BJwDI9WsNI+bA728YZ2y2DyUl/aNBxAIKb8=;
        b=a3N8iehVvZMywa4yn3NyXBpLikcBzyN/2/VQ4vW4j3LbYEi29mqXs2/d1Xz7+KUCYX
         YRIY7U6GMEHAfcEIyrXRbbWqYZG5O6oBHG88zQL2Ofz9QvoYIg3G6Mkan3JenwNWsqn5
         DD+XGk7iOi9+2ARdZfGfTP3LkEE4QyYmsQFbon/z2Hq6A+T8s/vHrgkfYP5SYkjUdQVe
         MCShj1Rf3jyeLrb/2SXJz4h1Me8cWKyJY99HQE/uPXL8Am5jkkUMQq1AvR3FKz1RdSGt
         NTSqHGDKhre6RCpoWxxZ+G3wJLQapCWwLGIfwrvf5jl0RYGgqYQ+y7+msbJj7hXkxtBq
         K6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qa8OBz62BJwDI9WsNI+bA728YZ2y2DyUl/aNBxAIKb8=;
        b=gpnS7u2ZuVO4hH3WiGs1B7QkquWbUMVzNvoXA8/TQoIFRlxg6+ckexMqN3CntONbod
         CVmSkJfVp1PLHVc/4EIveS+CCdRWaXTOXnznt4Vbl3RMl+DmEuPp+byxDlA3DO26Oa/m
         S1J/0n78LK3fTwoTrBTLE1ZBcbUMxakVBhWea+vHnVIsI4qyzdSsSjwo8K3I5Wdy4YbB
         CDLcZpute4ecCfcfX2GfuQnncUUYMu9gUK9rLDpEaP/qJRymkiH4SVG6HTWJUFVihZXl
         4bxhktMSzc4B7JizeJ2JL5F39M264bXAoXClueaS+pxgjeIoeaUK61ZkQcaAFJPhOBfM
         q1iQ==
X-Gm-Message-State: ACrzQf28zIvdeh/L8n+Wgp/FakOm52n9lRIb0mluylmqTyojw+ifnvyF
        e8OKq5LK0II5kUNiiZ4hqw4=
X-Google-Smtp-Source: AMsMyM4OXG4ZQM/WzB4IzHsffHqm2JF6IwbZeMqeGN1IIAmalHphLz1QLZLK+EubhLagIzhk//bvYw==
X-Received: by 2002:a17:903:2cb:b0:171:4f0d:beb6 with SMTP id s11-20020a17090302cb00b001714f0dbeb6mr29083644plk.53.1664326124910;
        Tue, 27 Sep 2022 17:48:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1a91:59b8:faf:7b4f])
        by smtp.gmail.com with ESMTPSA id u65-20020a626044000000b00554722eda37sm2449829pfb.0.2022.09.27.17.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 17:48:44 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:48:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     zhangsongyi.cgel@gmail.com
Cc:     zhang.songyi@zte.com.cn, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] Input: synaptics-rmi4 - Convert to use
 sysfs_emit() APIs
Message-ID: <YzOZ6qaiO2EzhPyG@google.com>
References: <20220927070936.258300-1-zhang.songyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927070936.258300-1-zhang.songyi@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 07:09:36AM +0000, zhangsongyi.cgel@gmail.com wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the value
> to be returned to user space.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Applied, thank you.

-- 
Dmitry

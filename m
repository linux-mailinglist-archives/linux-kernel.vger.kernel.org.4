Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF36D62492D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiKJSQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiKJSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:16:12 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D841A806
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:16:10 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id 7so1393036ilg.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqXDyseogDTLpFF0eQHv9pOMaqFVWgVUbVjrKvFMsy0=;
        b=5ycQ1sacv7ViSywRAaNstwvoGkdomC5JIRvZIkKbU9rck8mmh3GieD2uo/M4nG261Z
         vLI8kNdoBruGSniE5hS6Q2HKx3gNULA/IsVx6DseuhOXHBdqxyIItoOhVs5Fr348bUEg
         uPvZAAqzh98Y092uZs+LfzrG2YoRfvEKEmUpoDiBy98sgY8S0SMBL9GTDx0R3jyBmFYf
         iHbhizld9PESZraYOU9OPtQ1YZrwwoUMNT1Y10lzqX3Tb2yiZ7I+R7t8wsXwjTiHjyTJ
         dKvwF5X/gV53zx4r+2UBR9mS2SkTxFvo7EXjoTESAJuKLva+E7r+DAdGcCCZ7WrOSmdX
         L76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqXDyseogDTLpFF0eQHv9pOMaqFVWgVUbVjrKvFMsy0=;
        b=Wayo/tXbRagqXfoGZjkgsqb7hrF452XYNU447RyRHeNJlk4L5hqE/27QlBwMcUiW3z
         NK3HFJh39iucmrVhEWxbR1XtD7kAfwo0ytb/BMHgoMcjMjwl7IdL13yHWxyr74e3MKG8
         ND3WzgMLsYuW1HsDOzO1oWfzORFlLezw3LlAFvxY3PRNBn4F9t4Qrwf+owQK0RWQbGMO
         JqCQZ08lbggtB8q7YFmaLvgVN4PgjMkZBVPd78VFnjPJS0HAkEp38Qn5pshdo+bG3A+6
         ETFr78i0blS1PgHJYTAWdEZvsj/pWQfp/YeshFRPsaLm2NtODIsiBDdPVbz9piqAtNHb
         b7eA==
X-Gm-Message-State: ACrzQf258p7HTNKiAOhztnA0cM5iRDy4OwyrwuK8JL8P3DEBVztVrX2k
        OEt3idV42YwrTv9DxfAvBSBcG4WOgkTrsA==
X-Google-Smtp-Source: AMsMyM7wUzyJCMy2ly1qpNqkFird1qvyTn2mB5jZlKmwnt+SUAUKAgFGKJ0Y/tZ8LeRzzgTrXsVB7w==
X-Received: by 2002:a92:d84a:0:b0:300:bee0:1468 with SMTP id h10-20020a92d84a000000b00300bee01468mr3307519ilq.129.1668104170287;
        Thu, 10 Nov 2022 10:16:10 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s2-20020a02b142000000b00363cce75bffsm31120jah.151.2022.11.10.10.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:16:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lin Ma <linma@zju.edu.cn>, asml.silence@gmail.com
In-Reply-To: <20221110060313.16303-1-linma@zju.edu.cn>
References: <20221110060313.16303-1-linma@zju.edu.cn>
Subject: Re: [PATCH v1] io_uring: remove outdated comments of caching
Message-Id: <166810416930.167294.6129265009506240894.b4-ty@kernel.dk>
Date:   Thu, 10 Nov 2022 11:16:09 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 14:03:13 +0800, Lin Ma wrote:
> Previous commit 13a99017ff19 ("io_uring: remove events caching
> atavisms") entirely removes the events caching optimization introduced
> by commit 81459350d581 ("io_uring: cache req->apoll->events in
> req->cflags"). Hence the related comment should also be removed to avoid
> misunderstanding.
> 
> 
> [...]

Applied, thanks!

[1/1] io_uring: remove outdated comments of caching
      commit: ff611c848d0fd408ce90ef93a09ea0a70400cd86

Best regards,
-- 
Jens Axboe



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22210701D83
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjENNCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjENNCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:02:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115261BFE
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:02:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64ab2a37812so13917677b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684069319; x=1686661319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgGnPOVW+jIsBNOHMq2yRd/iIdLAkqP/raisUJk9qEQ=;
        b=lSt9/Of52sobaJ4kW8BwXFt31M/MuJK76UXNagH/cMZa2zj5j1VqOGYzIHqDGtNj5S
         mhAj4KueMtZhkUCAjmGBVrUXNSHnrAKfODgZ3S5Ri0yl76T3c/WjlQMLJhbjYjdq+VZn
         yKr9rG0ybDgZHmljrI/3IybjdzNKoxSuGqmBHNXR+RlYTZ4TkXKyO6fk+2NyJtULNaWw
         6/f+35n31rUU6AmAz13lO/yM0hV1bm29dXzl+WF4+2GvMCiLDgH0uuq+iacF/Tkvqu9G
         qb46exrV0Uiem5J4tB3RdHSQdF3279LCGmnlIFC0O/qBSX+voZ/f0KH/v1WuX53b9ys7
         7i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684069319; x=1686661319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgGnPOVW+jIsBNOHMq2yRd/iIdLAkqP/raisUJk9qEQ=;
        b=f9esUR8yrjD7YtXiTYXeRECVzuxgK+tt0QyCqpxxqSOzLe2LuJYEMUKKGUo9NMfqQt
         z8lH6D1XPeYiLq0zwU6yf3bUV58ljbx6bFBl27u4+ju5RxWbZhd88FJQ7rY2uABlqrt3
         lCC+WnTNMxH9eLvTGIi16Yqlgk7OVWrZ0rmzWmAtvERicLhT07CwaLPNxmagR0y2uRk0
         aiWJPjXbFYzQoXUOE8eDng3ki8OrPBs7E1wghEi9K4bzDIc2lEfTQQEULMkcS4H7nBAA
         AWakhsPXI3S904Lxc8GH8w5Kk9KMRAGdNo1oCe4gUHYy7NSEDKw5klF/cCv8wDogrMFd
         69OA==
X-Gm-Message-State: AC+VfDwulebBFDgi7zj/ev5sUrlI40nxMjk4ooQlgmIDmBgBsulsc7mc
        u0FAudkXSAdPZiWB2YWc8D6LQcfZelgBgQ==
X-Google-Smtp-Source: ACHHUZ5AUNj5aZ7begBx5i9E4Wz/GAkEhaP86c5SG9oj5ml4uKJdnEUFfknzHW94a+QHBo56gCI0Xw==
X-Received: by 2002:a05:6a20:2452:b0:104:f9d4:1413 with SMTP id t18-20020a056a20245200b00104f9d41413mr5890307pzc.5.1684069319382;
        Sun, 14 May 2023 06:01:59 -0700 (PDT)
Received: from redkillpc.. ([49.207.202.99])
        by smtp.gmail.com with ESMTPSA id e35-20020a635463000000b0051b70c8d446sm9766146pgm.73.2023.05.14.06.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 06:01:58 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        prathubaronia2011@gmail.com
Subject: 
Date:   Sun, 14 May 2023 18:31:46 +0530
Message-Id: <20230514130148.138624-1-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023051411-happier-mural-a8ef@gregkh>
References: <2023051411-happier-mural-a8ef@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback. I have gone through
Documentation/process/submitting_patches.rst and have split v1 into
logical commits and added appropriate commit messages. Please let me
know if there any changes required in this.

Prathu



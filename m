Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460A46154EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKAWZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKAWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:25:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A5C1035
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:25:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z18so18820776edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y0TtHVNR0Zt2jBbXANXyzyZbG58TNvz96BB5dak+Do=;
        b=XTD1f7Yp1DKCBTkuRWo2+SvHQxYrb6N1nL03Lr76IqyAxIsPcJtgrsAxq8dokZGxpf
         Pf9aHTVUu2ry1awbP1Nk2Tqva0NMyq+Ml5AYGTbrIpKoHESdjVoPmwey/OJylxbSRT49
         Y316EdFrieSqTgP2uWz+rihiXkVtjpne1MrcZCmVCSrOQ85Fn4rDAJvyIj73YylwcqmI
         NKj6zuvvBoK0w9rr09a1yjFrTnQLW3eYtj2kxVIUYKA0Led89We1MY1E+wVhMUoKF6vo
         GQjS9Q7k+1TMAOx4/tKUwkMPH9gJcNhX4vvr8wmKPiMpqIhFTBqHbEjDdB862qAjf/YS
         pcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y0TtHVNR0Zt2jBbXANXyzyZbG58TNvz96BB5dak+Do=;
        b=M01X6MtO/rGw9VZpcDzrtLlMBeVwT43QuJy1V1QWk5xMh4BM3kbOHYuX6M7rTREdCR
         vAzWGizsgWiziKYbcSbYZ0Yisxv23CnVgDdr5ubaVx7Pcd1NFESqoNOhXIhnzFJlA3Zb
         SZ3i8rd9nUy+bLEaEg6qfq9234IDM9uIGJUm/QPkPvRNxzgRXtQFln8oWNFpU3tCe8xn
         GaLywyn1Svb3xebc02EE6WlqbGaWeVt7JQ8u7MB2OHRemkrK9C5HHtVWNQfXa1ee+iy7
         LYpZxT8JCQNGLgK64Um4O/AZIbSRe+Go02wjnv9WSDkz8hRgTbh37dCWTwe9Wf7rKwvG
         PXIg==
X-Gm-Message-State: ACrzQf1k/W1ZnBc4ou0A7jZbTtfBORibQ675431DRRj1rqrtH+lf0VvI
        5BZRlKX0iVCaL6K35lKIOzM=
X-Google-Smtp-Source: AMsMyM6LzPa2RCiNmCR+IRBXvZBNmChmGLbhjGBuWPneabK4epdnsZKYenQf3jxpNORYfuMBLkXSeQ==
X-Received: by 2002:a05:6402:51c8:b0:462:3e90:aef with SMTP id r8-20020a05640251c800b004623e900aefmr21986115edd.225.1667341510532;
        Tue, 01 Nov 2022 15:25:10 -0700 (PDT)
Received: from ZBook.localdomain (86-90-194-80.fixed.kpn.net. [86.90.194.80])
        by smtp.gmail.com with ESMTPSA id z20-20020aa7c654000000b0045b3853c4b7sm4964843edr.51.2022.11.01.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:25:09 -0700 (PDT)
From:   Jerom van der Sar <jerom.vandersar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: space formatting fixes in rtl_cam.c
Date:   Tue,  1 Nov 2022 23:25:09 +0100
Message-Id: <20221101222509.4596-1-jerom.vandersar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f391a7cd-e57a-0643-1ba1-c859bf2f83a6@gmail.com>
References: <f391a7cd-e57a-0643-1ba1-c859bf2f83a6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 23:11, Philipp Hortman wrote:
> WARNING: Unexpected content after email: 'Jerom van der Sar 
> <jerom.vandersar@gmail.com>.', should be: 'Jerom van der Sar 
> <jerom.vandersar@gmail.com>'
> #14:
> Signed-off-by: Jerom van der Sar <jerom.vandersar@gmail.com>.
>
>
> I cannot apply your patch.
>
> Bye Philipp

Thanks for the catch. Will fix.

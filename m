Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCD86C128C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCTNEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCTNEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:04:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E983510406
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:04:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o12so46405949edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679317453;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYkYe0s+IOc674XO7nGCXdKMIejdUVLswaxdvus6GTI=;
        b=Ro6PruTgIfdBEHo14n27u6YJrs6TqCzjTMO5Mipdduwr5bHMpJ6UmoFoDsp2e8dRNf
         lQb8fN8iPPAvDAhlIGhy13FBkHsUCMMLw+1iKLJvKb8/N+oftvfAaurEgMD49nJ3VWfP
         QBsQujPSLmWDUc8U7NC10XiS90y5djNlr9SewHg4hCAMSJ/Cdrk63WB7658gYmttj+8j
         8IzyDasrRmv2uUXv8fcvss0M8ZKkR1YulGuklzU+CZVPG0tycsHykshY0Mjq8taZUisP
         9hgTdsPbpeBqwXpU4Dg8wWhgUW4weySJ7oPbH2ze5XgaKa3FoIeYa46Y++Yl5rrw7OGR
         76Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679317453;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYkYe0s+IOc674XO7nGCXdKMIejdUVLswaxdvus6GTI=;
        b=vrkkvBK9Das7022aNbeWaIypITGSOPwljubI7XLLAHJsDSa0+8lkQ5BUAQP+lHmOMb
         +1IuESYXRUQC0YarmQQ2sf92ambJNbWp6q/emKbbpCVhTr10uVwrkh7TaxA4RxOzK7p5
         aMk5M/EdHu2z27dpxuq+12bXrmcAfOD/6aG9a4j8zy2VfiUGsHdZiMn6yGEPuz6/Ne4w
         NTRS0ATTvBbw8M4fbsqiYTQsjHi9SLtUw2YcC9FxmXSPrjg58EzLLJ+rDCb0Sjz+kT/T
         y5w0TCfChYzl/q0o5z1v4gWQXeVc1Ly7LqmRa/hxlrdC512whCIAgLcK6rcTuu6brAH2
         irHw==
X-Gm-Message-State: AO0yUKVERQ72NWSp4SLzWNmYc3czq4RODRTuwvwQO5FHlObQEDL5+5bH
        8jPYvtffOa7qNLF4geHtsuqjy0PjVkXk4YFsvjU=
X-Google-Smtp-Source: AK7set8flpoOoYjc3H5BSe6l9kcLRduYeW1SaNjg6bk6+oy6o/kegFiEFvxvSyh86o8PYy999QDNTgyAZJX5DECvh0s=
X-Received: by 2002:a50:a40d:0:b0:4fe:9251:d4fc with SMTP id
 u13-20020a50a40d000000b004fe9251d4fcmr6444351edb.4.1679317453299; Mon, 20 Mar
 2023 06:04:13 -0700 (PDT)
MIME-Version: 1.0
Sender: higginbottomyao@gmail.com
Received: by 2002:a05:6358:290c:b0:104:5d2e:6aa4 with HTTP; Mon, 20 Mar 2023
 06:04:10 -0700 (PDT)
From:   Robert Wilson <robertwilsonca036@gmail.com>
Date:   Mon, 20 Mar 2023 13:04:10 +0000
X-Google-Sender-Auth: 0hhq126R8DYQtF2GeR2a3okOzzg
Message-ID: <CAG=Upk1XF6tsom0-aDyhuXdR3k4Kb1vf3sX4j=LHZvW2_croEQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,
I wrote you on the 25.10.2022, please check and reply me .
Thank you
Robert

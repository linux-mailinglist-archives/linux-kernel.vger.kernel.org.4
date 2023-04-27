Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B06F0C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjD0TQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjD0TQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:16:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53E019B6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:16:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a69f686345so69159145ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rethinkbizservice-com.20221208.gappssmtp.com; s=20221208; t=1682623008; x=1685215008;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J3OdwHSbEKh120yKYqPXOlZHz3A9jgXVZSPwKLOo6SA=;
        b=ZOl/0Xq+Sott9Vtg2R05em94KhD7MdOeOsYyga2R2dOK4h/yzLvZcfK+wv5aueQMry
         RfbyikWmNa0n4cp1OE06haaGWvtxmtBr2IsDDFiQEwmFHbLGg9rRwgbKvlrCT7UX6gr9
         uOUVP0bBJXDEoh5Tb3kg83fZGl9JJ+t+hAbJstFJ4+DOv3RtLnc4EsJ7X4evsbq40BR5
         dKthpG1rcNv/YazX9t+7njKwaOAwMUdVNx2ncZ8Wk6U0dVT8XX9xeKfdLgoIilUyUvGD
         sFd603ER7Dwye1UObnoeo9KvnpAYcSe+kTK4hdUHHXRDgsQX6wdCGDA4CE3KfdDK2xN/
         cZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682623008; x=1685215008;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3OdwHSbEKh120yKYqPXOlZHz3A9jgXVZSPwKLOo6SA=;
        b=hclt/BmvyXlgEfeOP7Fo+ixXL1gTRs1XhtMuDpgtth2sGXrQsnvgt4lo8j6VuRjwSg
         Mcfv+MK/CmNGaQXXnN+6s+9NUK7E8F2g5GE10Bw6KkQYVRQKb+3VrtbPyEG5mAHOO5Dt
         n5C+UAQAeNwJLTgYLkQFAaCJpmtXC+i5zG8Mcxksn6lZJ9ZY7oIaJXI7gomqM8jfSkNf
         3QYz685A07Vo9x1gtEdWDaxNZy6CAKzi2psJA6DMk/LOvsvS+cqcwzzzqy3wfOuxRw6t
         KjYEp0YTBIVtbZFTsblonKV8Vd+/5BGtfha4M+7XC3nfNpZeWDB5zIFk3QgL97gUWxMJ
         a11A==
X-Gm-Message-State: AC+VfDz3ykQJSzA8dyogdnWugSGNv6GGanvJzUlSaq6UrgnVUY3OWrZy
        9Omz7y1duntwTVsuc2XZ2Do5p1hqAuOT5pf/i6Yvvw==
X-Google-Smtp-Source: ACHHUZ7KQtbdag6EfXcAf7myb5KCK0BUvOBnfitTrDDrYAW9wxqp2aVYWudhPuMWJIUNEQuO/um1t/4CZiONqTRpcYU=
X-Received: by 2002:a17:902:ecca:b0:1a6:4127:857 with SMTP id
 a10-20020a170902ecca00b001a641270857mr3249631plh.5.1682623008181; Thu, 27 Apr
 2023 12:16:48 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Taylor <adam@rethinkbizservice.com>
Date:   Thu, 27 Apr 2023 14:16:36 -0500
Message-ID: <CAG5wPR7snWQ3zhJdG6=hMh5HuwyaZFFHyj0O_gRdeOitG6VQ4g@mail.gmail.com>
Subject: RE: Retail & Grocer Trade Shows attendees Email List- 2023
To:     Adam Taylor <adam@rethinkbizservice.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring Retail & Grocer Trade Shows
Attendees Data List 2023?

Conference                                    Counts         Cost
NRF Show                                     34,458        $1,989
Shoptalk                                         9,850          $1,489
Retail Innovation                            18,525        $1,689
National Grocers Association         10,525        $1,489

You can acquire all the shows at discounted price of $4,289

Looking forward for your response,

Kind Regards,
Adam Taylor
Marketing Coordinator

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946FF6FBBA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjEHXzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEHXzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:55:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8EF35A8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 16:55:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115eef620so38418947b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683590108; x=1686182108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=kEDnz3HBHpwlfpsmiIKoxFtmB7UopMLc791cfXEFTHVEM2V06tbocn3GNL9PXegqrk
         lKFozCWqhCfHqs/xKMhtjzLYfumrIc3/qd+YMM4NVaPJcRHtOdQKsEJEIkw/u/jtrWDC
         2STrSj0a/H15eizoL0flgSJ/9Zx3svNtzSLUH1CUTrQMAk1+WrpMZyNcr8k0VRDlqYgM
         8AttIRLuQoL6JY53l/9ov3tkkkElwtTYEfXPsI4WS15EOy1eMgTomMJ1P4JQWmraAX6A
         IvzobrnF623SUtXSxQP3POSdOrUHflP7Qx8yAU+ceID3Uus3BHv0WqvuYk+L1raU922w
         ivUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590108; x=1686182108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=QV2aSl72a1skFI/MNg8GLyFGsu3Mpb8UaMRmmdXw5pQuDDSVbeH7nUihRiJrEntaEm
         Xdl9bVL99vnVmxdMNh25Ra38ICdDQfW9z7QBAbOJW5p11qQduig0Ecl9PLCde+Ivwf/M
         Y6q3+zKPagNcm8epveK+Et/AQt3kT/fnP0E/g1QXn67MYLTGAeSHz2xy8RHbSoqNjRVQ
         sJbtcu6+gNCuO4M5gajOkii+JmaoJ3Xp+E8OBeLJujJ0Fgu1ilGeOSbntUgVIC7qbqkD
         oUAbHECgvMHwXYOpLbxXwkDqY8MZeKafqk5CYDLW0kx0/AosuJGBJguU+jf1zA/HSYkg
         pwSA==
X-Gm-Message-State: AC+VfDzX/MeqrmXelAZmKYBULSqLUp1/3Gw7CjZuFM0ovS7fZEx/ZktE
        0HOX2tWNLV7O0+p5QJ9qNZw=
X-Google-Smtp-Source: ACHHUZ6uUlRVwCl7xqtVWvmPEWKSEwObz7Bs5nIR2W97LJ6xWTMOpMeR2LdVumAU0g4rKOI9wdnWcA==
X-Received: by 2002:a17:90a:db07:b0:250:50c5:cabc with SMTP id g7-20020a17090adb0700b0025050c5cabcmr10017677pjv.3.1683590108029;
        Mon, 08 May 2023 16:55:08 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id lr8-20020a17090b4b8800b0024752ff8061sm18727035pjb.12.2023.05.08.16.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:55:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 13:55:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/22] powerpc, workqueue: Use alloc_ordered_workqueue()
 to create ordered workqueues
Message-ID: <ZFmL2r5z1ZSuGZQW@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-2-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421025046.4008499-2-tj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to wq/for-6.5-cleanup-ordered.

Thanks.

-- 
tejun

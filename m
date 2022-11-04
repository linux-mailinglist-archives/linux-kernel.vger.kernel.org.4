Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64B618D63
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKDBDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKDBDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:03:06 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B68061D647;
        Thu,  3 Nov 2022 18:03:05 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 14E851E80D9D;
        Fri,  4 Nov 2022 09:00:58 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RvKhFYbAS8pM; Fri,  4 Nov 2022 09:00:55 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7EDA61E80D9C;
        Fri,  4 Nov 2022 09:00:54 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     chuck.lever@oracle.com
Cc:     anna@kernel.org, jlayton@kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Subject: Re: [PATCH] sunrpc: svc: Remove unnecessary (void*) conversions
Date:   Fri,  4 Nov 2022 09:02:52 +0800
Message-Id: <20221104010253.2621-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <52658929-14AE-49AB-80DE-F0C68DD29D3D@oracle.com>
References: <52658929-14AE-49AB-80DE-F0C68DD29D3D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


of course, I will submit a new one to delete the static svc_ungetu32() function for Patch.


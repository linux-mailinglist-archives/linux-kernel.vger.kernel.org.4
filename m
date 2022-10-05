Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DAA5F5052
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJEH3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJEH3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:29:19 -0400
Received: from mail-m118207.qiye.163.com (mail-m118207.qiye.163.com [115.236.118.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 315E27434D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 00:29:17 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.62])
        by mail-m118207.qiye.163.com (HMail) with ESMTPA id 66F8C900A5D;
        Wed,  5 Oct 2022 15:29:13 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     me@inclyc.cn
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        ndesaulniers@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org, peterz@infradead.org, david.laight@aculab.com
Subject: Re: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Date:   Wed,  5 Oct 2022 15:29:13 +0800
Message-Id: <20221005072913.982634-1-me@inclyc.cn>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927153338.4177854-1-me@inclyc.cn>
References: <20220927153338.4177854-1-me@inclyc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWRpDH0hWTh5MThkeTExKSkhCVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VTUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hNSlVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRQ6LRw*FzkMCTYXS1YoIwIa
        DQIKCjxVSlVKTU1PQk5PQk5PT09NVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU1JWVdZCAFZQUpJT0I3Bg++
X-HM-Tid: 0a83a70c712e2d29kusn66f8c900a5d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly ping :)

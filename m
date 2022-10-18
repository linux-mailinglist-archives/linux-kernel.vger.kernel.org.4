Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DED601FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiJRAxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJRAxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:53:14 -0400
Received: from mail-m118204.qiye.163.com (mail-m118204.qiye.163.com [115.236.118.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3720804B3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:52:58 -0700 (PDT)
Received: from lyc-workstation.. (unknown [221.212.176.62])
        by mail-m118204.qiye.163.com (HMail) with ESMTPA id 5F6D6A21F6A;
        Tue, 18 Oct 2022 08:52:50 +0800 (CST)
From:   YingChi Long <me@inclyc.cn>
To:     me@inclyc.cn
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, david.laight@aculab.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        ndesaulniers@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v3] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
Date:   Tue, 18 Oct 2022 08:52:44 +0800
Message-Id: <20221018005244.3877315-1-me@inclyc.cn>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006141442.2475978-1-me@inclyc.cn>
References: <20221006141442.2475978-1-me@inclyc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFPN1dZLVlBSVdZDwkaFQgSH1lBWUJKQ09WS01OGkpPH0sdGR0eVQIWExYaEhckFA4PWV
        dZGBILWUFZSUlKVUlKSVVKTE1VTUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6SRw4HjlMIzUQFhIVSSwV
        KTJPFEtVSlVKTU1NS05PSExKT0pIVTMWGhIXVRYeOxIVGBcCGFUYFUVZV1kSC1lBWUlJSlVJSklV
        SkxNVU1JWVdZCAFZQUpKQkM3Bg++
X-HM-Tid: 0a83e89436882d26kusn5f6d6a21f6a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping :)

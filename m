Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099536EB9A7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDVObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:31:23 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1616F18E;
        Sat, 22 Apr 2023 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682173878;
        bh=fcZ123v+5iWe00iPixPiJvoNEQTtOF1P0aFwqsZgykQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a5Bm4/J4WXjEnWzxqpr999x1seqGHN2JkQmGCzRaYeK/zo5eIQmG8FVCokNxQ8l7E
         Wjm+QHI4B8fq3o6gbgKCrwthumfrdcGC5azHJCXLmNpIWfTmJBATI9StQ5VU5mcoBs
         xoURUXiIKld+gNk8WVY8bfDHdk6+RxNlkiecKnlw=
Received: from rtoax.. ([111.199.190.121])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 7D017ACB; Sat, 22 Apr 2023 22:31:16 +0800
X-QQ-mid: xmsmtpt1682173876tfm69o0a8
Message-ID: <tencent_08445EF147F310070D7884E0B2402E6F5509@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSazu/r0TvtxdBx7lab9HUfROFNsTSxW/fF7XpcIFrO253+8S4WN
         rFEb5UdWBVJkyhtIZEYQNCmVPVPuqA/j8+Yo6KYda7D3KucCKR8aKf8PcxF3N827WCiWHL7NFiVq
         B+qpglHBnBO9Ft3MtKDp+I9MLIWBJGpuV8E+5//RRNcSnSTjsfy06vX8zd22Zwqlo8Pqgtf6yunS
         mPUM9bhK7dMFm+pzeIzxryrs6YyYTLgg/zUu2KT8iq32TOldPg4pjOaYjPvMJhWg3F8Gi7XJNlef
         drq0hAlp3DI/7W2cMoj51bEjW9CTm3AE9ifJhw1bcxB3YvZv4ClYmD2fY78T+1j4CiauQGCgvMZ2
         0glf7ytBloMrhwt3S4q8MKNxtTKz7XOO89LSHLirE3MY1ffckjFX2pgJLlcXOg9XFxiFYiZVxeSa
         6MNWPocol1Hryqc68QEvgjU3FwIrj5puLFhBcDzzwlPZy7jdOCnb8vbYcYSA6i1eJEMQ38vZ/k+d
         EjVEN0W5jBKTxMHgHRBf5pYNiQkYZUfpZtKfVowG6U8YcVlNbgr5xWalxXzLwdedcE2KapchQ8SF
         2yxoLeAPtTqFJ3Fs6NCvQIlHRQ/4jJC3dw22z3blMocIAjT2D+R5a/xKwHfMWBTVytGX2cABL3FO
         EN0dTXhPLo0hnxaAkOWt53PANXoUKyQDYEIXOK2Iv9PCuuyN0S8Q5LuYn7Gid9d/2fblRsj7GNoi
         xKWCzJZmcIqLM9+RGD/dWMetfU8EPglE6K829Zip8u86CvE83qNONPepuGV7mFUkzb5JMqnn7UD+
         yXeIkNSV5iVyuYEbmK91WI9SfHex0SgxDSnAx+dqCafpw2XC+0Il0BRsYuVMg8DTx6TL+Ox+DDtM
         KTtAAKa8nVg0M+TNh5OAuK7uxhL7daQ+deQm71HWCJYnccTqwuGxPLzjzfm6cYaYaq81pwDoTin0
         fqjdja4lK1l4+LgxIEEFn0lSNTu/rSl7Fx2rCQ5T6eL5wQV/ZJ0TbNvqMS0JWo
From:   Rong Tao <rtoax@foxmail.com>
To:     william.gray@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        rongtao@cestc.cn, rtoax@foxmail.com
Subject: Re: [PATCH] tools/counter: Makefile: Remove useless 'include' when make clean
Date:   Sat, 22 Apr 2023 22:31:15 +0800
X-OQ-MSGID: <20230422143115.60507-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <ZEPrLfRajOjhv52l@fedora>
References: <ZEPrLfRajOjhv52l@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, William. I submit v2, please review.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EEC5FF4D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiJNUsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiJNUsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:48:35 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Oct 2022 13:48:34 PDT
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0596E183D9D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:48:33 -0700 (PDT)
Received: from sopl295.home ([109.220.248.156])
        by smtp.orange.fr with ESMTPA
        id jRUKoZbe2JvOZjRUKoWP7L; Fri, 14 Oct 2022 22:41:01 +0200
X-ME-Helo: sopl295.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 14 Oct 2022 22:41:01 +0200
X-ME-IP: 109.220.248.156
From:   Robert Jarzmik <jarzmik.robert@orange.fr>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 hzhuang1, rjarzmik
References: <20221013214637.30853-1-palmer@rivosinc.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 14 Oct 2022 22:40:59 +0200
In-Reply-To: <20221013214637.30853-1-palmer@rivosinc.com> (Palmer Dabbelt's
        message of "Thu, 13 Oct 2022 14:46:37 -0700")
Message-ID: <m21qrai1es.fsf@sopl295.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@rivosinc.com> writes:

> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert

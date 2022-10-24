Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9643C609E26
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJXJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJXJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:39:45 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E15A41AF26;
        Mon, 24 Oct 2022 02:39:40 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 2F9FC1E80D74;
        Mon, 24 Oct 2022 17:38:23 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tdZp91qkmLYB; Mon, 24 Oct 2022 17:38:20 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 794481E80CA5;
        Mon, 24 Oct 2022 17:38:20 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     bagasdotme@gmail.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, zeming@nfschina.com
Subject: Re: [PATCH] lxdialog: menubox: Add malloc allocation judgment
Date:   Mon, 24 Oct 2022 17:39:22 +0800
Message-Id: <20221024093923.179944-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <Y1ZIp1ZAu0VzQ9Wf@debian.me>
References: <Y1ZIp1ZAu0VzQ9Wf@debian.me>
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


If malloc allocation fails, the menu_item pointer cannot be executed, because when the strncpy function is executed, there will be a problem with the null pointer. Adding an if statement should ensure that the allocation fails and will not be executed.

thanks.


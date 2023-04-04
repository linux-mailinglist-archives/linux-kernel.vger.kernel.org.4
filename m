Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B976D6CFA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjDDTJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbjDDTJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:09:38 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9013268B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:09:35 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id BABCA124;
        Tue,  4 Apr 2023 21:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1680635372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lAB1BIOMY8BqcqgSGd6f7EUawi5jlbHQsRXoh9cOqk4=;
        b=mlpikNcY/mXReznB/BB0wm3JmwuaoXRGtacbJf89BNnuCCuE4R8qA0y2OXhZ+ocynwSMFs
        +Ra37Ednu8v8UEajd+zHCHX/rn7aCKEARtfs5/sFjJ0wCfpkH0PzDN0CASgwLGr381/uqy
        wTerxog+0ZBF4HUwjKDYVBJjpYb7jmJo8O67UT8HY/oB/uDgiVHaoD/s/OnqopLKZOHWIv
        kjfF4btOGkNc54PM/vSFiD00Tac+atgEVDdmMUWIF/9IwGi3jFi/EXybAXzm4PydD6cF7T
        cBaigX0tm+ILj2wMDrg72dx598U9aVpncjetwGJ4hsceFHtz0XrCT7RUbEPelg==
MIME-Version: 1.0
Date:   Tue, 04 Apr 2023 21:09:32 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tom Rix <trix@redhat.com>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: layouts: sl28vpd: set varaiable sl28vpd_layout
 storage-class-specifier to static
In-Reply-To: <20230404163629.1923871-1-trix@redhat.com>
References: <20230404163629.1923871-1-trix@redhat.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <cce4b409e20b073431b44a44f7f0a614@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-04-04 18:36, schrieb Tom Rix:
> smatch reports
> drivers/nvmem/layouts/sl28vpd.c:144:21: warning: symbol
>   'sl28vpd_layout' was not declared. Should it be static?
> 
> This variable is only used in one file so it should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Fixes tag?

Reviewed-by: Michael Walle <michael@walle.cc>

-michael

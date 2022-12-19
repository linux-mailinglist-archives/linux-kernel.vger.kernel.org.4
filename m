Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01E65139D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiLSUGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiLSUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:06:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC7D13FBC;
        Mon, 19 Dec 2022 12:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=56hqKbpHP1YjnjhImi4j+661IO16LOp9nFhLyHlGpTA=; b=UnvotzfOhPbQ2vZas8p62aRE+T
        0NqmDneBLRtzX6Io6jBtBAJXsSWfNRwGM40H+L5SPJEVdP1erZRLBXLUKMVBM5eRnqwKCI4XpT/Gn
        XieeIxMtXiEa/tj5UJHgHS/pMKhTy00OaRmhbuE9YaHYB3Nw5E8Bu1mYkKVBAF7ohuMBCCud0w0Bd
        WtI9i7Zasv0pksnHTkFHSS0tRIvlnx1aURQO/ITEgY5c/f/1L9t5XhHdoXXvqNjy0d3tM310A89gu
        KTNX30dyZEqDaq2BkDyBblCld/TNCpNPuEPb5/II9dqF+iMNihHMjFnYlv8c4P6RHeUeHo7Mgx5jc
        ivvMsTlg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7MPQ-001fAF-DH; Mon, 19 Dec 2022 20:06:49 +0000
Date:   Mon, 19 Dec 2022 12:06:48 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v8 0/9] Generate modules.builtin.alias from match ids
Message-ID: <Y6DEWDeNw/yOXWWQ@bombadil.infradead.org>
References: <20221216221703.294683-1-allenwebb@google.com>
 <20221219191855.2010466-1-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 01:18:46PM -0600, Allen Webb wrote:
> Generate modules.builtin.alias from match ids

This is looking much better, thanks! Please expand with proper
documentation on the use case / value of this on the file:

Documentation/kbuild/kbuild.rst

  Luis


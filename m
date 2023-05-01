Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842766F3A88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjEAWem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjEAWej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:34:39 -0400
X-Greylist: delayed 347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 May 2023 15:34:07 PDT
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D2D3AA7
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 15:34:07 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1ptc0I-00032Q-PM
        for linux-kernel@vger.kernel.org; Tue, 02 May 2023 00:28:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Akemi Yagi <toracat@elrepo.org>
Subject: Re: Linux 6.3.1
Date:   Mon, 1 May 2023 22:28:13 -0000 (UTC)
Message-ID: <u2pedt$k6q$1@ciao.gmane.io>
References: <2023050123-resubmit-silica-ac32@gregkh>
        <c2ac55a4-aaf5-2f49-be08-d326fe0c17f8@googlemail.com>
        <2023050202-slouchy-princess-e7dd@gregkh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: Pan/0.149 (Bellevue; 4c157ba git@gitlab.gnome.org:GNOME/pan.git)
Cc:     stable@vger.kernel.org
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_05,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 May 2023 06:40:03 +0900, Greg Kroah-Hartman wrote:

> On Mon, May 01, 2023 at 07:22:56AM +0100, Chris Clayton wrote:
>> 6.3.1 FTBFS thusly:
> 
> What is "FTBFS"?

"fails to build from source".

Akemi


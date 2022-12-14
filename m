Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C505C64C55E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbiLNI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiLNI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:57:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AED193E5;
        Wed, 14 Dec 2022 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+UA0bGsdjGZ9cSI5EhvAhiICSEqFY599X3vnO6vPNp8=; b=C/SwXNY37BskgDiZKGwdrvpdG4
        On0DmRm99sLiWdIdBMSTn1oSI4VMncAtR+6a1Qjl1oqu21U1J8GonjNni8iZpG+gT9TOR7mbJa2zE
        IKG+CoWf0GbY2WMh4QPBGUD9jLk7ogHzJ1WgV2p94OBkWl/hSjBKu2I0ZKPx9TO4h7STQtOVcu+7x
        /SmCWe3hmyhAq4sJPNFIApAbjle29nMfPYdZ4Ht3DD12cuc55cmqDpn9H989fk5pcREm8A+KZLgRK
        pbpH7I/AdItoJiOCNU6mXDlY5ebSOWRyiI1CDc7GnMp6FvzeRszuQ2dkzi0RQf188/BvTAIotoCbo
        aseyv0eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5NZz-00EqzR-OX; Wed, 14 Dec 2022 08:57:31 +0000
Date:   Wed, 14 Dec 2022 00:57:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Puma Hsu <pumahsu@google.com>
Cc:     gregkh@linuxfoundation.org, mka@chromium.org,
        dianders@chromium.org, albertccwang@google.com, raychi@google.com,
        howardyen@google.com, leejj@google.com, hch@infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: core: add implementations for usb
 suspend/resume hooks
Message-ID: <Y5mP+yQwlbbZb+9P@infradead.org>
References: <20221214081456.714859-1-pumahsu@google.com>
 <20221214081456.714859-3-pumahsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214081456.714859-3-pumahsu@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again, this is never actually registered.  It it not tied to an device.
What is the point of all this?  Are you trying to fool us?

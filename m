Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA49678722
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjAWUE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjAWUEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:04:53 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52FCA3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:04:51 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1pK33c-0008P0-NC; Mon, 23 Jan 2023 21:04:44 +0100
Date:   Mon, 23 Jan 2023 21:04:44 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] staging: r8188eu: always process urb status
Message-ID: <20230123200444.wrix3bldpalxzcgz@viti.kaiser.cx>
References: <20230110205626.183516-1-martin@kaiser.cx>
 <20230110205626.183516-5-martin@kaiser.cx>
 <bfbdb94f-c965-0b07-3539-c1a057e5b0b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfbdb94f-c965-0b07-3539-c1a057e5b0b4@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thus wrote Pavel Skripkin (paskripkin@gmail.com):

> Not sure if it matters but we still have that weird rule that after 5 failed
> usb read/writes bSurpriseRemoved will be set to true

> Maybe also worth removing above logic?

thanks for making we aware of this retry counter. It does really look
strange. Still, I'm not sure that I understand this well enough to
submit a patch for removal. I'll play around with this as time
permits...

Best regards,
Martin

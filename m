Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE5163BBC9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiK2IgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiK2Ifc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:35:32 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FC819002;
        Tue, 29 Nov 2022 00:34:12 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67ACB68AFE; Tue, 29 Nov 2022 09:34:09 +0100 (CET)
Date:   Tue, 29 Nov 2022 09:34:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] elevator: use bool instead of int as the return
 type of elv_iosched_allow_bio_merge
Message-ID: <20221129083409.GD24762@lst.de>
References: <cover.1669391142.git.nickyc975@zju.edu.cn> <1a179a01463c7dbbc1b2be09111ea35617f763a9.1669391142.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a179a01463c7dbbc1b2be09111ea35617f763a9.1669391142.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:53:14PM +0800, Jinlong Chen wrote:
> We have bool type now, update the old signature.

Looks good, especially as the allow_merge method already returns a bool:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E591710B57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbjEYLqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjEYLqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A6F9C;
        Thu, 25 May 2023 04:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 730E3644FE;
        Thu, 25 May 2023 11:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92611C433D2;
        Thu, 25 May 2023 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685015165;
        bh=C/zNYk5n/8dZq/cXW0DPYu4rjNZYvW1wj1SqiGzpz1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEa+KBPnNUBwDlYP6HWO8RCRdvzgbFxXs2PQtB44tAXcSctFGSklWBcKmyCADAHyK
         cTrDF4DA3d4vsIvxt1yO3bPou/xCtASvF1ckuw8jkLZw4D77BmiYgViKUoB73ctMAD
         aF6CRWvg1IiAdtMY6oTpZxC9MMNAhywZadBKj6zTD9oxjOpXlC5/mSvh6TmSltxauy
         FZlKyk2NvJ6EDTFW2/U/H9UApUGdJcdEx8CTc6Bq5QKZeKN71CXZKxUN14d/SueSCl
         MknZ/7+3DwyIkcdGTj/eWBVAkYNKYsEgBosMNZUWgKW7ZSD7dVWSSkV5WuvbOBPull
         CpnIrqHGH4LBg==
Date:   Thu, 25 May 2023 12:46:01 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mfd: stpmic1: add pmic poweroff via sys-off
 handler
Message-ID: <20230525114601.GJ423913@google.com>
References: <20230516132225.3012541-1-sean@geanix.com>
 <20230516132225.3012541-2-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516132225.3012541-2-sean@geanix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023, Sean Nyekjaer wrote:

> Use devm_register_sys_off_handler() that allows to register multiple
> power-off handlers.
> 
> This can be enabled by adding "st,pmic-poweroff" to device-tree.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  - Removed superfluous function
> 
>  drivers/mfd/stpmic1.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

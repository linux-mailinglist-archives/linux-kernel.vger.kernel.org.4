Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E706A96D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCCL51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCCL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:57:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2763C5D880;
        Fri,  3 Mar 2023 03:57:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9D81B818A1;
        Fri,  3 Mar 2023 11:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0371FC433D2;
        Fri,  3 Mar 2023 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677844637;
        bh=2Oz5PwF+1UGmgg2mfDe7VGnadXlhuUDsiuUacLQbwlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpkN8EZ3cwGZGF//9F7wi8vAoQudZqWs5k4iYi57eiHYRBE21tEwqGR3MHD1AErRm
         rMMCUwxKNDUGH8lRhKuhD1dU71y65lcNG3ZKD0+B+2q/QTmnBaD/h08p1hfZqFLsvZ
         DZZE0i0jUZxqjS6l4Xmv5pJCBcJQDbWUjMHKXvXewx1fTYIbZSfZ92kZLcJV6MaTzQ
         znbZMj3qB2/r3qfq9asbqMnUiKXUa8+p0y5iOkVCIvljyMZ0h8Rtnr77kmclO/BdjD
         9SzJvrpic7h7DW+Fa5FZnAhskpOjcq7LP80/jy9duW/zMITaIBJfJ03TkU/zW6PEIp
         TYmsWRJp/8qlg==
Date:   Fri, 3 Mar 2023 11:57:11 +0000
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: qcom-wled: Add PMI8950 compatible
Message-ID: <20230303115711.GI2420672@google.com>
References: <20221226-msm8953-6-2-wled-v1-1-e318d4c71d05@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226-msm8953-6-2-wled-v1-1-e318d4c71d05@z3ntu.xyz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023, Luca Weiss wrote:

> PMI8950 contains WLED of version 4. Add support for it to the driver.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> While adding dt-bindings and dts in a previous series I forgot to add the
> compatible to the driver. Fix that now.
> ---
>  drivers/video/backlight/qcom-wled.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]

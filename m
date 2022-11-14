Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074A46281EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiKNOEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiKNOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:04:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41441C40E;
        Mon, 14 Nov 2022 06:04:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A037B80FA1;
        Mon, 14 Nov 2022 14:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01E2C433C1;
        Mon, 14 Nov 2022 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668434666;
        bh=ihqKdfvzr+MJGAopVFCLO48wogcjiAx8bOZpihBcRlI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=tjvqXZXUIntYUIyp0AJV3MN4q61UwnJfQPqJigQHy1JpjA/ydtRnqxYucbdttmFQ7
         yAv9WpzPto1b32xEtUM6x7ulJhCOKARn+P5oq6XS+cp8q2Q39yD1RFahrMS0HDCH4a
         uSzXETfwd89xsIKpyhiBkyPiB376Wda0SChDbiWbtjAzv6Rttx31XwgeEVC3ZJhwxf
         ZFnM69kyxrCig4HSsYYILnm6HT0NcxcTjuePh2zLKi7N/x0YlXIRNOE+p7e5dn8wK/
         bRzx6FMpcaPmJpyDkEdn9NbdgCN5SEccMJMZ+rERDqzuVeiYSlyUHg1MdL3Q8WeRPV
         PbvsKOyAtwaJw==
Date:   Mon, 14 Nov 2022 15:04:24 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, mairacanal@riseup.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Standardize test name prefix
In-Reply-To: <20221110174955.398885-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211141504120.6045@cbobk.fhfr.pm>
References: <20221110174955.398885-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022, José Expósito wrote:

> Commit 961bcdf956a4 ("drm/tests: Change "igt_" prefix to "drm_test_"")
> introduced a new naming convention for the KUnit tests present in the
> DRM subsystem: "drm_test_<module>_<test name>".
> 
> This naming convention is very convenient because it allows to easily
> run all subsystem tests or all driver tests using kunit.py's wildcards.
> 
> Follow the naming conventions used in the DRM subsystem adapted to the
> HID subsystem: "hid_test_<module>_<test name>".
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Applied to hid.git#for-6.2/uclogic. Thanks,

-- 
Jiri Kosina
SUSE Labs


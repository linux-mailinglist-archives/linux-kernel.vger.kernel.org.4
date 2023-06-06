Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57E4724960
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbjFFQlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbjFFQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:41:07 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180C81727
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686069610; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=cxxZILsV0Ck3s4Pv6m2kv3XjsbugVskLts4ojIUyNRGoevSJ97cZz9y1LyG4Y0NHhttpQ1hmMkht3Ql6n+XXnQ+D9bsyJUhfazEYil0a0kSXepGxI1rshLjni2uIHI3sLD/4v7cFljW9gL0L7aKiRCMqjayM2Nhs5SK31B856BE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686069610; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qKSjPJMWWmkJECp3tZYh7BuSC4IcgzJdVvdj6SWJe14=; 
        b=Nl0mQfdYRXZMRCOIPCkp5TIeVVnIUcRbW3xoHqeYVFEo7Oe3RCZ/iWC/vOLgRfuQMPBLaZtVXkgUD51XSsD9xuHzsQHKw0yI9AtHGwhqXGKq7e7XEdD12rdwwTPXcWZ+LqK68uv4K/d1hVb6bR93HO49qTbj+0Er+YfufbrsJ1I=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686069610;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=qKSjPJMWWmkJECp3tZYh7BuSC4IcgzJdVvdj6SWJe14=;
        b=l9qLXr7hIw2fBddDcXnpirDWqIqhWTcBDSXFZg2zo4k7m6lI7KXWLGcaVzg51zCS
        zbWiZKAk7Q4yL3uQ5vF1ckpeOUS/b9TwDjX++8U4MNs2VUDf9RJhxZspdkHef4znqGY
        U4H9M5BtOpsXTHf5755tVfDPbRtG5ZObbDzJxws8=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1686069579485900.0175054100046; Tue, 6 Jun 2023 22:09:39 +0530 (IST)
Date:   Tue, 06 Jun 2023 22:09:39 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
Cc:     "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Andrzej Hajda" <andrzej.hajda@intel.com>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Robert Foss" <rfoss@kernel.org>,
        "Jonas Karlman" <jonas@kwiboo.se>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "dri-devel" <dri-devel@lists.freedesktop.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Suraj Upadhyay" <usuraj35@gmail.com>
Message-ID: <18891940ece.3f2000a5125546.8342497114650501146@siddh.me>
In-Reply-To: <20230606144625.GF5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <52c8eb0f241a9d67ce5b7e6fc64dc397e735ccd8.1686047727.git.code@siddh.me>
 <20230606142322.GB5197@pendragon.ideasonboard.com>
 <1889125187d.5d36766d120183.6659725053490512400@siddh.me> <20230606144625.GF5197@pendragon.ideasonboard.com>
Subject: Re: [PATCH v9 3/8] drm: Remove usage of deprecated DRM_INFO
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2023 20:16:25 +0530, Laurent Pinchart wrote:
> I would write
> 
> drm: Remove usage of deprecated DRM_INFO in DRM core
> 
> The "drm: " prefix doesn't imply you're touching the core only, you
> could do a tree-wide change that also touches all drivers.

Okay, will send a v10 with the change after resolving discussions in
other emails, if any.

Thanks,
Siddh

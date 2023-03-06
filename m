Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5956ACED7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjCFUFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCFUFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:05:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B2548E02;
        Mon,  6 Mar 2023 12:05:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1875B81106;
        Mon,  6 Mar 2023 20:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A122C433AC;
        Mon,  6 Mar 2023 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678133133;
        bh=7aGV60npvHqtpD2KZbj09/ATSzY6ifh/i1if6W3gd4g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D1K+iOlR+AIRbRv93QXZnzeNuquqsYjjqN4/YcPp/fZ6sUbv8KhpRrgL+ncUSlD07
         D5O0IYHWh7BRaLxbTo01mwwKB0TYCJcEd3QK3+aJpNXiycJtWiePMIzL/xVk3Tx2KN
         rDVC5N/jeZ4Qk3HR+uye77zvmWXuoP9GV8lRNFAIHlZW0fjT6XDoAMW60SZrvApIU8
         ksDqOYGBLmZ5OZRhMGA8udfSaAKU6ImROnXQ8rjbTAtadPkipuxhOQi5+WcxLIqEU8
         s7Zf2By11p7YhjJLYz1fxcJZHcH2qx9lDHqG2fNREvzhRYG7NNlaWgA2fLb2szHoHY
         mnf+BaH3AvHNA==
Received: by mail-ed1-f53.google.com with SMTP id u9so43725029edd.2;
        Mon, 06 Mar 2023 12:05:33 -0800 (PST)
X-Gm-Message-State: AO0yUKX/3jxnP6Nq3r+7m98294HrMTkV7JnUnuC5Cl2cqWMWmmgUfN3w
        F35ZeVmujacGssz0IYRJKCR6Acrnjy89iSjhmjs=
X-Google-Smtp-Source: AK7set/1eKTbJwQDLH579qb/v4dU5t+rNalaL06DcZNQXB8YFSECcnZJKc8FFLD3DOzXqQpD5dLXg9oxaE3QLoFBwDs=
X-Received: by 2002:a50:d581:0:b0:4bf:5fd5:da40 with SMTP id
 v1-20020a50d581000000b004bf5fd5da40mr6349414edi.4.1678133131533; Mon, 06 Mar
 2023 12:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20230306160016.4459-1-tzimmermann@suse.de> <20230306160016.4459-23-tzimmermann@suse.de>
In-Reply-To: <20230306160016.4459-23-tzimmermann@suse.de>
From:   Timur Tabi <timur@kernel.org>
Date:   Mon, 6 Mar 2023 14:04:54 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUtkyg5Gv3HYCK-U1pQpY0_QBk99wtqUvz5RVy2W3Ak9w@mail.gmail.com>
Message-ID: <CAOZdJXUtkyg5Gv3HYCK-U1pQpY0_QBk99wtqUvz5RVy2W3Ak9w@mail.gmail.com>
Subject: Re: [PATCH 22/99] fbdev/fsl-diu-fb: Duplicate video-mode option string
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
        adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@hansenpartnership.com, spock@gentoo.org,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        geert+renesas@glider.be, corbet@lwn.net,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 10:01 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Assume that the driver does not own the option string or its substrings
> and hence duplicate the option string for the video mode. The driver only
> parses the option string once as part of module initialization, so use
> a static buffer to store the duplicated mode option. Linux automatically
> frees the memory upon releasing the module.

So after module_init is finished, mode_option_buf[] no longer exists?

> +                       static char mode_option_buf[256];
> +                       int ret;
> +
> +                       ret = snprintf(mode_option_buf, sizeof(mode_option_buf), "%s", opt);
> +                       if (WARN(ret < 0, "fsl-diu-fb: ignoring invalid option, ret=%d\n", ret))
> +                               continue;
> +                       if (WARN(ret >= sizeof(mode_option_buf), "fsl-diu-fb: option too long\n"))
> +                               continue;
> +                       fb_mode = mode_option_buf;

If so, then I'm not sure that's going to work.  fb_mode is used after
module_init, in install_fb(), which is called by fsl_diu_probe().

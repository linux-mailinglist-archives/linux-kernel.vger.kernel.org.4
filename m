Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21C1734493
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 02:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjFRAye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 20:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFRAyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 20:54:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37493E5A;
        Sat, 17 Jun 2023 17:54:31 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77e2ed26037so25854839f.0;
        Sat, 17 Jun 2023 17:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687049670; x=1689641670;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqKTty0qe15Zn8weDjTvayLuu/DxI1mnCLQjju5jfp0=;
        b=TQQZQsYKojQDd3y+QG2BodhjqiQDylZilxyabUTGZBH0NwnKnb78SkUTMY5H/6/lJY
         xAO2c7YjO/5psBGeOLJv2v1fsL5z694eQd+Rr/IQVp/aNc8pjq6PTZydS5PWRhPPTEd3
         iBTChYEQzaxgQzvqndk+bdi+Tce3TdUaA13GsysOxvEFH0HdyJVGpxsTSNWOiK+Fiep4
         eHN/f2qmUUF7jETC0NEcmjmn6k6wHwAE22UcGYntJg1uMdXz5FJNsg8agWPXsAsnlH3/
         Wcbv3aUpePaVa8rg3hVxKCme6wTjQ4o0lKBgDalwigtmzUOhxsLuwOrvxrrwy92uVkwz
         AlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687049670; x=1689641670;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqKTty0qe15Zn8weDjTvayLuu/DxI1mnCLQjju5jfp0=;
        b=dnHWVPggfHaTLSC2DJy0yOcvDmiPGEDmrouTVrVpZVZCWIF1uUoHPVYACIEVdmiIzZ
         7NLha119AVO810mfINmXWbrHshxZoyoq/kNbpYEM3S8w91A0mY/N3VwXK/Rt1AgAfI6P
         NKM6tMkCErIEgW1uGRe8DUI7yeqWsK1tpwDePVxdB+7DqdN7mEvMnqHDK9jd2Pznrpq4
         iN1sMMrmhbvWgIZtyf8T+SgNOHsL3AJYpbMIlERgZfjA9MvtODowAOpMkfhaZRz0Xdm1
         /mZq2ki9FXiUS2LmSNXGARs+2QVLSZS8vCYhejRX7nPy7Wb8xripjqIj7YWr9C+cZVz6
         m6Aw==
X-Gm-Message-State: AC+VfDzbNHL+e9SOUoKsTfrAXIy10ODSNkV+8uBecmbBBE5LpRILyOMM
        7R4FFA6U2LQqV7iPOF8ZxAA=
X-Google-Smtp-Source: ACHHUZ5btfq9whilg7Xv8uzVRxc04zrnG1qRPsnvEKOBkaAejbWTKrYZ4cZylhNyh5C5GsBhB/rW1A==
X-Received: by 2002:a6b:f61a:0:b0:77e:288d:f3c1 with SMTP id n26-20020a6bf61a000000b0077e288df3c1mr2106254ioh.6.1687049670457;
        Sat, 17 Jun 2023 17:54:30 -0700 (PDT)
Received: from vcheng-VirtualBox ([45.72.231.44])
        by smtp.gmail.com with ESMTPSA id n21-20020a056602221500b0077a89f99a01sm7621048ion.34.2023.06.17.17.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 17:54:30 -0700 (PDT)
Date:   Sat, 17 Jun 2023 20:54:28 -0400
From:   Vincent Cheng <vscheng@gmail.com>
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>,
        richardcochran@gmail.com, netdev@vger.kernel.org
Cc:     simon.horman@corigine.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, harini.katakam@amd.com, git@amd.com
Subject: Re: [PATCH V2] ptp: clockmatrix: Add Defer probe if firmware load
 fails
Message-ID: <ZI5VxN8o+VvwrZ+5@vcheng-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 12:51:08AM +0000, Vincent Cheng wrote:
> 
> 
> -----Original Message-----
> From: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com> 
> Sent: Wednesday, June 14, 2023 1:12 AM
> To: richardcochran@gmail.com; netdev@vger.kernel.org
> Cc: simon.horman@corigine.com; andrew@lunn.ch; linux-kernel@vger.kernel.org; Vincent Cheng <vincent.cheng.xh@renesas.com>; harini.katakam@amd.com; git@amd.com; sarath.babu.naidu.gaddam@amd.com
> Subject: [PATCH V2] ptp: clockmatrix: Add Defer probe if firmware load fails
> 
> Clock matrix driver can be probed before the rootfs containing firmware/initialization .bin is available. The current driver throws a warning and proceeds to execute probe even when firmware is not ready. Instead, defer probe and wait for the .bin file to be available.
> 
> Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>

Reviewed-by: Vincent Cheng <vincent.cheng.xh@renesas.com>

> ---
> Changes in V2:
> 1) Added mutex_unlock(idtcm->lock); before returning EPROBE_DEFER.
> 2) Moved failure log after defer probe.
> ---
>  drivers/ptp/ptp_clockmatrix.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c index c9d451bf89e2..b3cb136257e3 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -2424,8 +2424,13 @@ static int idtcm_probe(struct platform_device *pdev)
>  
>  	err = idtcm_load_firmware(idtcm, &pdev->dev);
>  
> -	if (err)
> +	if (err) {
> +		if (err == -ENOENT) {
> +			mutex_unlock(idtcm->lock);
> +			return -EPROBE_DEFER;
> +		}
>  		dev_warn(idtcm->dev, "loading firmware failed with %d", err);
> +	}
>  
>  	wait_for_chip_ready(idtcm);
>  
> --
> 2.25.1
> 

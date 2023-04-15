Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43D6E3163
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 14:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDOMnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 08:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDOMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:43:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EABD422F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 05:43:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c9so13469573ejz.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 05:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681562605; x=1684154605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/U1EVhvmioxEWIZgOSAGDZ+lg8zKWYdBXw2nRcSafA=;
        b=XdjZ0ecoe3m5GeprHd2E/skpAQs49TAHnmG5JRrbqT79yKHwlx0WppkOsNO0w3GrfQ
         of0bdSWPjwrH7HgQXc4a9+alX6mpY8O444oxwYYRkYCiv7m5q2OtQWnxHKQApsdV5bDF
         UA6sS5HVCw5Vffyib2DLyQjmWqXmp6Wm5PQVjZWASBdrxfXmDKqAdwB/jZ6ct8rTgWRq
         xO6+OwSxwl4vRVIY+6cppz4+7eAvwEPABG/UCZrnAbCmHRkN05d+FC9FH7l445+4Rp2S
         Yvk5FAMEOKjOyM8MA5N/Z+AIZsDLr0r7c8MpIMmPyD5iC7O+8NHMRv1Zh5A4erZ0kDCR
         csHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681562605; x=1684154605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/U1EVhvmioxEWIZgOSAGDZ+lg8zKWYdBXw2nRcSafA=;
        b=hAkmKkYGE7yW9KwVRCgUbcZTFpmu65qEPvg0QdJkJ1LcuQZyV5++D4sx7yyf4cc+AA
         cxjuEzX8hbQkmxrbhkuaFiW4X7m9nM9VQYMPpG5sXAqAOBoWpHu6aJphEQm2tsm2I2xd
         ANztsq06hJK+Iyk26pl5NDF9RkkiQAxy+fuFYIRy8xk9MtFJNEzOGkk1uFaRpQKHqy2D
         L+BxdOQt7qP/32opAJj8eX86iL9E5hi3x0e1bJ4RRY2Q+h2Zd8lzlhlSyxgefnR/IiJ8
         Y/HQIdhRwi9VtZEoWcIFmLoDUJrU4d7d/QPJKgXngqQ2m0FpQBsw2ZCQCHErfHWMxKcC
         1lTw==
X-Gm-Message-State: AAQBX9e4QIxlaxw9V7C25soLVEFrFQiZBdItmzAxcWROG3OPfYlrwRm5
        D6H8sIFl8FiaB0rvTuUPCAc=
X-Google-Smtp-Source: AKy350bpAeF1kQWWtp+NVI6jLeI+pEP8H1bmjGpmwhUF0/v/EjW29kjm9IGnzOKQGPIdU/IxKvu7Ew==
X-Received: by 2002:a17:907:77ce:b0:94f:3d8:3d80 with SMTP id kz14-20020a17090777ce00b0094f03d83d80mr2054728ejc.11.1681562605528;
        Sat, 15 Apr 2023 05:43:25 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id qc27-20020a170906d8bb00b0094f364b36acsm138665ejb.165.2023.04.15.05.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 05:43:25 -0700 (PDT)
Date:   Sat, 15 Apr 2023 15:43:20 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Luke Koch <lu.ale.koch@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: replace rate macros
Message-ID: <714c5d3f-438a-4633-a46e-127f876ffec4@kili.mountain>
References: <ZDqKb1iuoSQTYXJM@kernelhacking.kernelhacking.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDqKb1iuoSQTYXJM@kernelhacking.kernelhacking.example.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 01:28:47PM +0200, Luke Koch wrote:
> Change p80211msg_dot11req_scan_results rate members to struct arrays
> instead of individually numbered member structs.
> Replace macros to set rates with loops to avoid checkpatch warning
> and adhere to linux coding style.

Writing every sentence in imperative tense makes people sound like space
aliens in human skin...  You can if you want to but it's not a
requirement in staging.  There are two maintainers who have that
requirement and the Outreachy people.

> 
> Reported by checkpatch:
> 
> CHECK: Macro argument reuse 'N' - possible side-effects?
> 
> Signed off by: Luke Koch <lu.ale.koch@gmail.com>
> ---
>  drivers/staging/wlan-ng/p80211metastruct.h | 18 +-------
>  drivers/staging/wlan-ng/prism2mgmt.c       | 52 +++++++---------------
>  2 files changed, 18 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211metastruct.h b/drivers/staging/wlan-ng/p80211metastruct.h
> index 4adc64580185..e963227f797c 100644
> --- a/drivers/staging/wlan-ng/p80211metastruct.h
> +++ b/drivers/staging/wlan-ng/p80211metastruct.h
> @@ -114,22 +114,8 @@ struct p80211msg_dot11req_scan_results {
>  	struct p80211item_uint32 cfpollreq;
>  	struct p80211item_uint32 privacy;
>  	struct p80211item_uint32 capinfo;
> -	struct p80211item_uint32 basicrate1;
                                 ^^^^^^^^^^
This starts at 1 instead of 0.

> -	struct p80211item_uint32 basicrate2;
> -	struct p80211item_uint32 basicrate3;
> -	struct p80211item_uint32 basicrate4;
> -	struct p80211item_uint32 basicrate5;
> -	struct p80211item_uint32 basicrate6;
> -	struct p80211item_uint32 basicrate7;
> -	struct p80211item_uint32 basicrate8;
> -	struct p80211item_uint32 supprate1;
> -	struct p80211item_uint32 supprate2;
> -	struct p80211item_uint32 supprate3;
> -	struct p80211item_uint32 supprate4;
> -	struct p80211item_uint32 supprate5;
> -	struct p80211item_uint32 supprate6;
> -	struct p80211item_uint32 supprate7;
> -	struct p80211item_uint32 supprate8;
> +	struct p80211item_uint32 basicrate[8];
> +	struct p80211item_uint32 supprate[8];
>  } __packed;
> 
>  struct p80211msg_dot11req_start {
> diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
> index 9030a8939a9b..069c39c36753 100644
> --- a/drivers/staging/wlan-ng/prism2mgmt.c
> +++ b/drivers/staging/wlan-ng/prism2mgmt.c
> @@ -437,42 +437,22 @@ int prism2mgmt_scan_results(struct wlandevice *wlandev, void *msgp)
>  		if (item->supprates[count] == 0)
>  			break;
> 
> -#define REQBASICRATE(N) \
> -	do { \
> -		if ((count >= (N)) && DOT11_RATE5_ISBASIC_GET(	\
> -			item->supprates[(N) - 1])) { \
> -			req->basicrate ## N .data = item->supprates[(N) - 1]; \
> -			req->basicrate ## N .status = \
> -				P80211ENUM_msgitem_status_data_ok; \
> -		} \
> -	} while (0)
> -
> -	REQBASICRATE(1);
> -	REQBASICRATE(2);
> -	REQBASICRATE(3);
> -	REQBASICRATE(4);
> -	REQBASICRATE(5);
> -	REQBASICRATE(6);
> -	REQBASICRATE(7);
> -	REQBASICRATE(8);
> -
> -#define REQSUPPRATE(N) \
> -	do { \
> -		if (count >= (N)) {					\
> -			req->supprate ## N .data = item->supprates[(N) - 1]; \
> -			req->supprate ## N .status = \
> -				P80211ENUM_msgitem_status_data_ok; \
> -		} \
> -	} while (0)
> -
> -	REQSUPPRATE(1);
> -	REQSUPPRATE(2);
> -	REQSUPPRATE(3);
> -	REQSUPPRATE(4);
> -	REQSUPPRATE(5);
> -	REQSUPPRATE(6);
> -	REQSUPPRATE(7);
> -	REQSUPPRATE(8);
> +	for (int i = 0; i < 8; i++) {
                 ^^^^^
Now it starts at zero.

> +		if (count >= i &&
> +		    DOT11_RATE5_ISBASIC_GET(item->supprates[i - 1])) {
                                                            ^^^^^
This is an array underflow.

regards,
dan carpenter

> +			req->basicrate[i] .data = item->supprates[i - 1];
> +			req->basicrate[i] .status =
> +				P80211ENUM_msgitem_status_data_ok;
> +		}
> +	}
> +
> +	for (int i = 0; i < 8; i++) {
> +		if (count >= i) {
> +			req->supprate[i] .data = item->supprates[i - 1];
> +			req->supprate[i] .status =
> +				P80211ENUM_msgitem_status_data_ok;
> +		}
> +	}
>  
>  	/* beacon period */
>  	req->beaconperiod.status = P80211ENUM_msgitem_status_data_ok;
> -- 
> 2.34.1
> 

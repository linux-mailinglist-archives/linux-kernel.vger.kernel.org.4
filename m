Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D728C74F006
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjGKNUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGKNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:20:17 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF9FE55
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:20:15 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-395fd55e523so4957962b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689081614; x=1691673614;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=el+P3SqF75IOt2Nw4zTb+xpVEskz3T2cAJxu07VogVY=;
        b=BAfnsJXRKKWbN+uN1o3tLzTGX8+n/zh0/STk/j6AJVad3fMSDpp5hXzTYYXbipIkxZ
         EkcCud61Qnc2vOYLyJkwD2/70nTs/LVvnRyxZtOtmaNjgdmCgM+EmgMN+8mWawMdUoGJ
         Z45hY69xGv2brhwVBUy7WFfzzbGQTXQoHKHycEIG+uXAKtAnnkUF/DLfZgxzepPcc0GB
         ivCWiBgoJFd2+7xr3fFCinoYPPjTdLNYM7EGYst7J+SIKTiesv/DisAH/5h4RViwj3eN
         5+B3xlapSEeaC8sYUjx3dmcHfIpYpje+USZxqX+hZoRncjsUBbYpTU36U2qSIPAJTDJ0
         6uaA==
X-Gm-Message-State: ABy/qLZJViKpuqrIVUPYySFWq9TW3uPoXuj7fhz8goUVSwSpmNP3ASqy
        yaxoyEYpXu0YHa8VeoEro46U/ZXYwvwqjZ0ynaVpxE91VIpC
X-Google-Smtp-Source: APBJJlFbr+afD/Iwmz0JYgomWPoPgKWOl96CjnsX3+ntjkD8NS7H9wxiEXIiFIOljjA2FvnOpTG3CUOL9og4WBNiBHGRkrNTyy/p
MIME-Version: 1.0
X-Received: by 2002:aca:bb55:0:b0:3a3:8cf6:5edf with SMTP id
 l82-20020acabb55000000b003a38cf65edfmr1375106oif.9.1689081614322; Tue, 11 Jul
 2023 06:20:14 -0700 (PDT)
Date:   Tue, 11 Jul 2023 06:20:14 -0700
In-Reply-To: <20230711131958.334-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e59f4060035f595@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_errqueue (2)
From:   syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
To:     hdanton@sina.com
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 10 Jul 2023 10:53:57 -0700
>> HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178f78d4a80000
>
> Put session without the session list lock held.
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git  e40939bbfc68

Your commands are accepted, but please keep syzkaller-bugs@googlegroups.com mailing list in CC next time. It serves as a history of what happened with each bug report. Thank you.

>
> --- x/net/can/j1939/transport.c
> +++ y/net/can/j1939/transport.c
> @@ -1083,7 +1083,6 @@ static bool j1939_session_deactivate_loc
>  
>  		list_del_init(&session->active_session_list_entry);
>  		session->state = J1939_SESSION_DONE;
> -		j1939_session_put(session);
>  	}
>  
>  	return active;
> @@ -1098,6 +1097,9 @@ static bool j1939_session_deactivate(str
>  	active = j1939_session_deactivate_locked(session);
>  	j1939_session_list_unlock(priv);
>  
> +	if (active)
> +		j1939_session_put(session);
> +
>  	return active;
>  }
>  
> @@ -2178,6 +2180,7 @@ void j1939_simple_recv(struct j1939_priv
>  int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
>  {
>  	struct j1939_session *session, *saved;
> +	LIST_HEAD(active);
>  
>  	netdev_dbg(priv->ndev, "%s, sk: %p\n", __func__, sk);
>  	j1939_session_list_lock(priv);
> @@ -2191,10 +2194,16 @@ int j1939_cancel_active_session(struct j
>  				j1939_session_put(session);
>  
>  			session->err = ESHUTDOWN;
> -			j1939_session_deactivate_locked(session);
> +			if (j1939_session_deactivate_locked(session))
> +				list_move(&session->active_session_list_entry, &active);
>  		}
>  	}
>  	j1939_session_list_unlock(priv);
> +
> +	list_for_each_entry_safe(session, saved, &active, active_session_list_entry) {
> +		list_del_init(&session->active_session_list_entry);
> +		j1939_session_put(session);
> +	}
>  	return NOTIFY_DONE;
>  }
>  
> --

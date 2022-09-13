Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D85B76C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIMQxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiIMQwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:52:45 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D74B868A0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:45:50 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id u132so12131676pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yc8058PkXCAtg4rHKIu3hxLG1CddP60qZcOVbsJ4j18=;
        b=WCPby2JavTqXlswIlflhyUFMlh0rgqRBAC4rKUkQt2HfZ6ZhyCYjjtQEI+8ka9l34W
         TIiX10rzIEis1SawhTUKYceUTJmTvlk+j7uBpAEp8SQ10mBbCJNVzZtVMIhQ+RTIs2uH
         KO+m8EXBXsty7ehR4ZQPk55tvt3wRor7fIPHClCbz7g5hHZBaQQOuLD+QfGPkfgBtnzF
         ztntnU0n4XP/KhD4zbEJH6lcJjSBn1PKSrp56iul0Xln7hYyftSiJUlm6fo6BQUuN+ZG
         OpMfX2tCTE92G6WalAOq67kOPKO2fhWI4s56aHMeFebnokQ0ryZV+j/CKF7AeV25RYS7
         vsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yc8058PkXCAtg4rHKIu3hxLG1CddP60qZcOVbsJ4j18=;
        b=LTdg1XfUuh3sK5HDqNJBGovo/ggkYcK3Z4LNXn0M5Qa+jUHQ71luD3bqcbCPlKfRCl
         SQ0laO+gdTXtn9mEKln4pqvF1wHGb6JvvXlHfdXxJqi7bpsFPQJQnSNNYt8Bodg5/XkL
         GRRNg3aCVOrb0469SmhB8m/RMMkynF8X0mcw9wRpkK2ThTTxYHzUz8Q6WO4bXWNMD0Tb
         uDT+ik/EpkmaBhlwO6VMMP6Nwt20PSTIoF5vGFCbz3bYDgE2VIQkWduVZFBsAaMaYc5B
         LCWzUIXmaYYSxggt/624+w0kC9SuAPbWFceARqU3TiGnQMpBJCXooIlU9G/vpVuF/vkz
         x3bw==
X-Gm-Message-State: ACgBeo3GvW4VifCGE7ieVLVAmJ+7CB5dhMGnF8YwpaBfQ2Y1XJHdlGA6
        3FKCRoEZXTqw5X0p07XOhyM=
X-Google-Smtp-Source: AA6agR6C2v578EhJi+UWM7gAL5jzlTJ8YsiOIiZE/geu3TzQi5/fYQ5A2EQFFj89jyxd53TvXTe9eQ==
X-Received: by 2002:a63:ff55:0:b0:438:fa5d:af36 with SMTP id s21-20020a63ff55000000b00438fa5daf36mr9466842pgk.533.1663083828708;
        Tue, 13 Sep 2022 08:43:48 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b00172897952a0sm8584864plf.283.2022.09.13.08.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:43:48 -0700 (PDT)
Date:   Tue, 13 Sep 2022 08:43:44 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Paul Fulghum <paulkf@microgate.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        imv4bel@gmail.com
Subject: Re: [PATCH] pcmcia: synclink_cs: Fix use-after-free in mgslpc_ioctl()
Message-ID: <20220913154344.GA92254@ubuntu>
References: <20220913052020.GA85241@ubuntu>
 <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
 <5BBF8723-AF48-4380-B05B-CB3B552322BD@microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BBF8723-AF48-4380-B05B-CB3B552322BD@microgate.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I don't have deep domain knowledge about PCMCIA.
I will abide by your decision.

Best Regards,
Hyunwoo Kim.

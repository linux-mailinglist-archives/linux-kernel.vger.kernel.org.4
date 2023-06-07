Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96899726FEE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjFGVDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjFGVC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:02:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7BD30E8;
        Wed,  7 Jun 2023 14:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1686171744; x=1686776544; i=rwarsow@gmx.de;
 bh=Er+zwqPxJ4eaj5y+E4fNQt8BY1zyZtWqItiyEDxWS68=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=tS8K+Ui0lqMiJt3cMgAv6a5KvYhsrDvBbZpAS9k6PGlO37gws3I94KrXH37+NRWAbpak/VQ
 nUt5a+UrrN10H8MA+VJZj2vmbQ0RXcXE8H33boCt4zY54AfnKi4gwSR3alwdzAY9xcAPvU6Jc
 krpfqMIRJjEbJFYhz0E0GDnWsbzlex/tfrx1iB6AxZCJ1OHD7RRGtw1xHVHS2QqMR+SspnYcL
 esG+zXi+W63VtNWDr7CU4KMvGl23UArRpvAGVwNDkl8k+2D5XYEqF8GRB40VjV6BUrBIq2lu3
 FCejc9NrS3bN/CsdRzGCfITpnXopOu4BCaT/lwdEyVV9bPyQAT1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([94.134.2.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdebB-1pXwf03ydt-00ZdlG; Wed, 07
 Jun 2023 23:02:24 +0200
Message-ID: <3a07aeb3-a6e5-6ee6-7806-ba6363707d37@gmx.de>
Date:   Wed, 7 Jun 2023 23:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 000/286] 6.3.7-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RV4U3bkDOL+JAzDZ8PHKHuoQCkMLgZ21gzwK2CC6DQis7osTM0M
 SPYIoFXd/YvkDP/ykt/9g1utQoAdGbdWUU//kuyW6RtlJOVQ5+If48HnzeJNfYUzitqdUbc
 7yL8qFDzHWqfHLv3pI4WM+mtqofCKJWMyoXI3QuAKu45R1paIqdEEEqHVcDr8roPWJVEb4m
 kEdHdzLfB3L4k7P6H6lng==
UI-OutboundReport: notjunk:1;M01:P0:IwDKWaRE1RE=;IEIn4IVZF81Z5whseX9K3EJ2Zmr
 9D88AFfVst75OhQpXdWlZt+QjxdNjozMwYt19wfRqTG3zVsMiB0tAQInpl61m6pPI6HrX0QBM
 Q9tBXezyDy+8dwft6f7Ahfk66P7tFoN6vm+ifh3Olxcu3XPSVfNeNROHHI+BSWaeg00aGCL0i
 MNxvVjmzDOp4ntLyENhzIZuVpwg8LlhhF9wP/H0o1Go92bq2xr6SVI0KCSiTpki/Q+Nj2qKnw
 1UbiGXt+NnsBRz5H1Nf4o8tD5S95J1oUpnL75+5mlwPSXtAlGFrto+cj12PDF2EghEbW8r7/p
 Bk83SqHVhUzmQbcTmZeFeGLEUBl2ehl+saKx8s+xaxufl94TGXZMtyll09K6pTuE8x2d5gq8P
 rqWR0c6KmYF1YD0J53FFR6LCVs2PJLFBz4/Qos8h0YZDrLINMWbu8vAw0GrqlQ+fst2IOfe+2
 PLqjdE08wxnXPBuhwMz2DC0KCnpIW8VFRBKgjtF6BR1cW2S//34bzmDKLdsuR1TmHaCqc6DGA
 QXr9W1G17kS8xAwBIXMRAxYMNtogxOD5pQH3+Kw+LNTX0F5h+8au4PZfi9LOLQdLFZm8ZNJSv
 MXDKyAZsPEO6jLF/tyy1xRYLK8fzeb7Z+BpQUFcDoj28e/alB8ieydCVCxi4MfzQSTqcdDqeN
 NCOK3E1G9G9ByEu5mpG8vP/nqbKxXlozWc8erVv+UBl84Xtsl9NSKXwqFW6OXlzD696qwpMBu
 5ONWktYvdIEebzQ3DOojr7emYiOTOjaZAXWYWco4euk3pjyb701PoB0ooGjg4C8OSA3mHM320
 r0Cr0af8EF1F7HWr/NgA7rHot5WnNHHBiEeoAu0za8lBnF3aujDZrfbCLhISiTBwhcH2XORwK
 emoSkOjZwI2Lb7Ip2kT5IhJziRVlWPxDKMZzZJzaghsanJkR6HgTbbiYKa8eradgtzSQWYdZ/
 DtaUeQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.7-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


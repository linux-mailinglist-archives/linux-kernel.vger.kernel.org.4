Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91B6CF85B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjC3AqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC3Ap5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:45:57 -0400
X-Greylist: delayed 2086 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Mar 2023 17:45:54 PDT
Received: from out1-37.antispamcloud.com (out1-37.antispamcloud.com [185.201.16.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4882688
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:45:53 -0700 (PDT)
Received: from mswmaster11.virtualsolution.net ([89.40.227.251])
        by mx243.antispamcloud.com with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <sodilecdistri1@gmail.com>)
        id 1phfsb-0004M4-O4
        for linux-kernel@vger.kernel.org; Thu, 30 Mar 2023 02:11:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=twostar.it;
        s=default; h=Content-transfer-encoding:Content-type:Date:Subject:To:From:
        Mime-Version:Message-Id:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/5wXXWJ3R6oitwyvUaRP3p66jHypizD9tZXV2B+75tM=; b=fmEQrscPHwCk/ALADxCZpA0SYi
        G17+hnvbMQNqAXLfDNq4b+M2xsUfOAU6c7myYCXbOXOvT3OFU+RvEOrqoP1wGxrZ6CQbBIPAyUw4J
        Gh0YGB1Vg903JQLwJPDRZOWkMyJ+rYDyhpybL7xFhW+HDVmBgapCcrrZP6anr5O6rAFGVUNclFT+M
        VbxMtQsrED37hRnAaeaX7m+hIxeZ8f7le4Dig8duZhkt7vFOpu951YK3+PHRp+egUNZe0SGactEcy
        cfxAXUk4ao1OVXLntWK4f85CUlUNedoHNNmEobJ5Z/JbOimOtWtcoPtq0vPr0KQ+2T/0jGPqJQ3qX
        tuVp8ogA==;
Received: from [102.67.224.215] (port=60985 helo=[192.168.1.65])
        by mswmaster11.virtualsolution.net with esmtpa (Exim 4.96)
        (envelope-from <sodilecdistri1@gmail.com>)
        id 1phfsY-0002wk-1Q
        for linux-kernel@vger.kernel.org;
        Thu, 30 Mar 2023 02:11:00 +0200
Message-Id: <YZXEZQM2-EU8S-SIJV-Y6ZQ-JXF4XCNU5ZLC@proton.me>
Mime-Version: 1.0
From:   Manz Francis <francismanz2000@proton.me>
To:     "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Coucou.
Date:   Thu, 30 Mar 2023 02:10:58 +0200
X-Bounce-Tracking-Info: <bGludXgta2VybmVsCQkJbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwlDb3Vjb3UuCTI4NwkJNjAzMzIJYm91bmNlCW5vCW5v>
Content-type: text/plain; charset=iso-8859-1; format=flowed
Content-transfer-encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mswmaster11.virtualsolution.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Get-Message-Sender-Via: mswmaster11.virtualsolution.net: authenticated_id: sebastiano@twostar.it
X-Authenticated-Sender: mswmaster11.virtualsolution.net: sebastiano@twostar.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 89.40.227.251
X-Spampanel-Domain: 89.40.227.251
X-Spampanel-Username: 89.40.227.251
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=89.40.227.251@89.40.227.251
X-Spampanel-Outgoing-Class: unsure
X-Spampanel-Outgoing-Evidence: Combined (0.71)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8IFBBDyuCqFMhKvsrIJanVPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5z4WkZ/TJaiaBbP2NJqrVHtfCzdNGNoLjYW00m5NbCHvI9w
 knWGobBIYos3d1n2bRHvoDtWti+8t/IPMUMNMnjl5WCy5VkstzhnxgTXqsdmpxthXIjA4l+t8oaw
 RLIs9et93hy7w3M++4rxYiTtCSkOYveHf7ga7B9skVVnSQ2A3DJor6sQnNM7+uZA77FsUOjt6JtT
 TglxNZAq/da6Ra+k+2iLHaBlw5sAfNImh0hoNrzwDbDNWzNTu+9Rc3Z+LD8tJ/urtexBTb2Nca1c
 RzjI3WlqJWhCKKDbv2ECuYRrNAUpe2K4Anc22gsCTwgkqLoMoOLjGsRz/MUE6aIZoCcUNXR4aVG4
 tVHU1Zldyy+zfbnrM5aYo0PL7jUsZY4sbPZdjx85xQq9VD42UbTRudBo31/E3ahF5MMcDI7KdpjQ
 KUnh3QF2Y0MpRP8lNdFAmSaZ3JKVmi72ocgY5kMQSjs7oT+6/6ngnC3zT5MJtpTZ7L69ywUfK1GF
 yeI4etqXx2iqrJJ80NVlREkpW4CenvdvASJFC/49WOPBr5nlEUI4xJ5EPj/tYBghBQqVhmMHWZCQ
 q+HooRq3qFqpq3xV7kcu8+Ka85JZNLj3MiQDb4arqs9ztxCa6OqQqXUzcuP10JdHCXdmDF7LCsV3
 /AZkNTfehmzewSEwGaJ+2SM9TjSvclKOP/hFMrSq0fTHfSNkbNc2dJz53EohEeic18U+38eN8sIP
 ivIvZxmj0w+4lUOJ59lyk+AQkotsPJoL8t0u+9hlXr38NCALc+2SZmtOQ64n+lUH2/3NjSHxqwRi
 ZsYawnJME9/viFTthlS6d2BrNs3U70HJ4eoCk+EkbAxC7erbUVblQpgvLF6gDSq5snVXvTKkm9n0
 J/aW79FN5Tdbra+15VGBQwwGsChtoOPtKYDc3jR5NeVaJQBh0uawl0Cg8nrgSS6D7FozWS6JHKRE
 tqdEPzY64lXv2dr2sny4a4SjpIU2L0ZI1wj7vuRCSusYDKLTQiIbVL0FOqTShy0sXBM=
X-Report-Abuse-To: spam@quarantine14.antispamcloud.com
X-Spam-Status: No, score=1.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bonjour,

je suis Francis Manz citoyen fran=E7ais, j'aimerais par cette correspondanc=
e, vous faire un important don, vous allez trouver cela incroyable mais c'e=
st tr=E8s s=E9rieux, je souffre d'un cancer qui est en phase terminale, il =
ne me reste plus que 1 mois ou 2=2E Selon ma religion et mes croyances, il =
est important de faire une grande action =E0 un inconnu pendant ses derni=
=E8res heures, pour esp=E9rer avoir une bonne vie apr=E8s la mort=2E J'ai d=
=E9j=E0 fait des dons =E0 des associations mais maintenant je veux faire un=
 don direct=2E merci de bien vouloir m'aider =E0 r=E9aliser ce dernier vou=
=2E

Cordialement

Francis

